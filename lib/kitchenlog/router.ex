defmodule KitchenLog.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias KitchenLog.Repo, as: Repo

  plug Plug.Static, at: "/", from: "#{:code.priv_dir(:kitchenlog)}"
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]

  plug :put_secret_key_base

  plug Plug.Session, store: :cookie,
    key: "kitchenlog_session",
    encryption_salt: EntropyString.random(:session, :charset16),
    signing_salt: EntropyString.random(:session, :charset16)

  plug :fetch_session
  plug Plug.CSRFProtection

  plug :match
  plug KitchenLog.Plug.Verify
  plug KitchenLog.Plug.Auth
  plug :dispatch

  get "/", assigns: %{ fields: [] } do
    conn |> KitchenLog.Plug.Render.template("/recipes", [])
  end

  post "/login", assigns: %{ fields: ["username", "password"] } do
    # page = Poison.encode!(%{})
    # conn |> Plug.Conn.put_resp_content_type("application/json") |> Plug.Conn.send_resp(200, page)
    conn |> KitchenLog.Plug.Render.template("/recipes", [])
  end

  post "/logout", assigns: %{ fields: [] } do
    conn |> KitchenLog.Plug.Render.template("/recipes", [])
  end

  post "/register", assigns: %{ fields: ["email", "username", "password"] } do
    password = Bcrypt.Base.hash_password(conn.params["password"], Bcrypt.gen_salt(12, true))

    {:ok, query} = KitchenLog.Repo.query("""
      INSERT INTO kitchenlog_users ("email", "name", "password")
      VALUES ($1, $2, $3) RETURNING uuid
      """, [conn.params["email"], conn.params["username"], password])

    page = Poison.encode!(%{})
    conn |> Plug.Conn.put_resp_content_type("application/json") |> Plug.Conn.send_resp(200, page)
  end

  get "/recipes", assigns: %{ fields: [] } do
    result = case Repo.query("""
      SELECT * FROM kitchenlog_recipes AS a
      """, []) do
        {:ok, query} -> query |> Repo.fetchall
        {_, _} -> raise(Repo.DBError)
    end

    conn |> KitchenLog.Plug.Render.target("/recipes", [recipes: result])
  end

  get "/recipe/:id", assigns: %{ fields: [] } do
    IO.puts "..."
    result = case Repo.query("""
      SELECT * FROM kitchenlog_recipes AS a
      WHERE id = $1 LIMIT 1
      """, [id |> String.to_integer]) do
        {:ok, query} -> query |> Repo.fetchone
        {_, _} -> raise(Repo.DBError)
    end

    conn |> KitchenLog.Plug.Render.target("/recipe", [recipe: result])
  end

  post "/recipe/:id", assigns: %{ fields: [] } do
  end

  get "/recipe/:id/image/:uid", assigns: %{ fields: [] } do
    result = case Repo.query("""
      SELECT lo_get(a.lo) AS content, mime FROM kitchenlog_images AS a
      WHERE reference = $1 AND uid = $2 LIMIT 1
      """, [id |> String.to_integer, uid]) do
        {:ok, query} -> query |> Repo.fetchone
        {_, _} -> raise(Repo.DBError)
    end

    send_resp(conn, 200, "data:#{result["mime"] };base64,#{Base.encode64(result["content"])}")
  end

  post "/recipe/:id/image", assigns: %{ fields: ["image"] } do
    mime = conn.params["image"].content_type
    %{size: size} = File.stat! conn.params["image"].path

    result = case Repo.query("""
      INSERT INTO kitchenlog_images ("reference", "size", "mime")
      VALUES ($1, $2, $3) RETURNING lo
      """, [id |> String.to_integer, size, mime]) do
        {:ok, query} -> query |> Repo.fetchone
        {_, _} -> raise(Repo.DBError)
    end

    case result do
      %{ "lo" => lo } ->
        {:ok, content} = File.read(conn.params["image"].path)
        KitchenLog.Repo.query("SELECT lo_put($1, 0, $2)", [lo, content])
        send_resp(conn, 200, "data:#{mime};base64,#{Base.encode64(content)}")
      _ -> raise(Repo.DBError)
    end
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  defp put_secret_key_base(conn, _) do
    put_in conn.secret_key_base, Application.get_env(:kitchenlog, :secret_key)
  end

  defp put_csrf_token_in_session(conn, _) do
    # token = Plug.CSRFProtection.get_csrf_token
    # conn = conn |> put_session("_csrf_token", Process.get(:plug_unmasked_csrf_token))
    # conn = conn |> put_session("_token", token)
    # conn
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    case reason do
      %KitchenLog.Plug.Verify.OutOfContext{} ->
        page = EEx.eval_file("#{:code.priv_dir(:kitchenlog)}/templates/index.eex", [csrf_token: get_session(conn, "_csrf_token"), target: conn.request_path])
        conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page)
      _ ->
        IO.inspect(kind, label: :kind)
        IO.inspect(reason, label: :reason)
        IO.inspect(stack, label: :stack)
        send_resp(conn, conn.status, "Something went wrong")
    end
  end
end
