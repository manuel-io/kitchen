defmodule KitchenLog.Plug.Verify do
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

  def call(%Plug.Conn{request_path: path, method: method} = conn, opts) do
    case {method, path} do
      {"POST", "/image"} -> conn
        |> verify_fields(opts)
        |> verify_content(opts)
        |> verify_size(opts)
      _ -> conn
    end
  end

  defp verify_fields(conn, opts) do
    verified = conn.params |> Map.keys() |> contains_fields?(opts[:fields])
    unless verified, do: raise(IncompleteRequestError)
    conn
  end

  defp verify_content(conn, opts) do
    content_type = conn.params["image"].content_type
    # IO.puts inspect content_type
    verified = Enum.member?(opts[:types], content_type)
    unless verified, do: raise(UnknownContentError)
    conn
  end

  defp verify_size(conn, opts) do
    %{size: size} = File.stat! conn.params["image"].path
    # IO.puts inspect size
    if size > opts[:size], do: raise(OversizedUploadError)
    conn
  end

  defp contains_fields?(keys, fields), do: Enum.all?(fields, &(&1 in keys))
end
