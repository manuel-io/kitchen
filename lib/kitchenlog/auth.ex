defmodule KitchenLog.Plug.Auth do
  import Plug.Conn
  alias KitchenLog.Repo, as: Repo

  defmodule AuthError do
    defexception message: "AuthError", plug_status: 400
  end

  def init(options) do
    options
  end

  def authenticated?(conn) do
    case get_session(conn) do
      %{ "_current_user_id" => 0 } -> false
      %{ "_current_user_id" => _ } -> true
      _ -> false
    end
  end

  def call(%{request_path: path, method: method} = conn, _) do
    case {method, path} do
      {"POST", "/login"} -> conn |> login(conn.params["username"], conn.params["password"])
      {"POST", "/logout"} -> conn |> logout()
      _ -> conn
    end
  end

  defp logout(conn) do
    conn |> put_session("_current_user_id", 0)
  end

  defp login(conn, username, password) do
    result = case Repo.query("""
      SELECT * FROM kitchenlog_users AS a
      WHERE name = $1 LIMIT 1
      """, [username]) do
        {:ok, query} -> query |> Repo.fetchone
        {_, _} -> raise(Repo.DBError)
    end

    verified = case result do
      %{"password" => hash} -> Bcrypt.verify_pass(password, hash)
      _ -> false
    end

    unless verified, do: raise(AuthError)
    conn |> put_session("_current_user_id", result["id"])
  end
end
