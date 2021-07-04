defmodule KitchenLog.Plug.Verify do
  import Plug.Conn

  defmodule OutOfContext do
    defexception message: "OutOfContext", plug_status: 400
  end

  defmodule IncompleteRequestError do
    defexception message: "IncompleteRequestError", plug_status: 400
  end

  defmodule UnknownContentError do
    defexception message: "UnknownContentError", plug_status: 400
  end

  defmodule OversizedUploadError do
    defexception message: "OversizedUploadError", plug_status: 400
  end

  def init(options) do
    options
  end

  def call(%{request_path: path, method: method} = conn, opts) do
    session = get_session(conn, "_csrf_token")
    state = Plug.CSRFProtection.dump_state_from_session(session)

    {_, token} = Enum.find(conn.req_headers, {"", ""}, fn(element) ->
      case element do
        {"x-csrf-token", _} -> true
        _ -> false
      end
    end)

    case {method, String.split(path, "/", trim: true)} do
      {"POST", ["recipe", _, "image"]} -> conn
        |> validate(%{ fields: ["image"] })
        |> validate(%{ name: "image", upload_size: 5242880 })
        |> validate(%{ name: "image", file_types: ["image/jpeg", "image/png"] })
      {"POST", [_]} -> conn |> validate(conn.assigns)
      {"GET", []} -> conn
      #_ -> conn |> validate(%{state: state, token: token}) |> validate(conn.assigns)
      _ -> conn
    end
  end

  defp validate(conn, %{:fields => []}) do
    conn
  end

  defp validate(conn, %{:state => state, :token => token}) do
    verified = Plug.CSRFProtection.valid_state_and_csrf_token?(state, token)
    unless verified, do: raise(OutOfContext)
    conn
  end

  defp validate(conn, %{:fields => fields}) do
    IO.puts inspect fields
    verified = conn.params |> Map.keys() |> contains_fields?(fields)
    unless verified, do: raise(IncompleteRequestError)
    conn
  end

  defp validate(conn, %{:name => name, :file_types => types}) do
    content_type = conn.params[name].content_type
    IO.puts inspect content_type
    verified = Enum.member?(types, content_type)
    unless verified, do: raise(UnknownContentError)
    conn
  end

  defp validate(conn, %{:name => name, :upload_size => upload_size}) do
    %{size: size} = File.stat! conn.params[name].path
    IO.puts inspect size
    if size > upload_size, do: raise(OversizedUploadError)
    conn
  end

  defp contains_fields?(keys, fields), do: Enum.all?(fields, &(&1 in keys))
end
