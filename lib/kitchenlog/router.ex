defmodule KitchenLog.Router do
  use Plug.Router
  use Plug.ErrorHandler
  # alias KitchenLog.Plug.Verify

  plug :put_secret_key_base
  plug Plug.Session, store: :cookie,
    key: "kitchenlog_session",
    encryption_salt: EntropyString.random(:session, :charset16),
    signing_salt: EntropyString.random(:session, :charset16)

  plug :fetch_session
  plug Plug.CSRFProtection

  plug Plug.Static, at: "/", from: "#{:code.priv_dir(:kitchenlog)}"
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug :match
  plug KitchenLog.Plug.Verify
  plug :dispatch

  get "/", assigns: %{ fields: [] } do
    # IO.puts inspect :code.priv_dir(:kitchenlog)
    # IO.puts inspect KitchenLog.Repo.query("SELECT lo_get($1)", [111876])
    token = Plug.CSRFProtection.get_csrf_token
    page = EEx.eval_file("#{:code.priv_dir(:kitchenlog)}/templates/index.eex", [csrf_token: token, target: "/recipes"])
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page)
  end

  get "/recipes", assigns: %{ fields: [] } do
    {:ok, query} = KitchenLog.Repo.query("""
      SELECT * FROM kitchenlog_recipes AS a
    """, [])

    token = Plug.CSRFProtection.get_csrf_token
    result = Enum.map query.rows, fn(row) ->
      Enum.zip(query.columns, row) |> Map.new
    end

    page = EEx.eval_file("#{:code.priv_dir(:kitchenlog)}/templates/recipes.eex", [csrf_token: token, recipes: result])
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page)
  end

  get "/recipe/:id", assigns: %{ fields: [] } do
    {:ok, query} = KitchenLog.Repo.query("""
      SELECT * FROM kitchenlog_recipes AS a
      WHERE id = $1 LIMIT 1
    """, [id |> String.to_integer])

    result = Enum.map query.rows, fn(row) ->
      Enum.zip(query.columns, row) |> Map.new
    end

    token = Plug.CSRFProtection.get_csrf_token

    page = EEx.eval_file("#{:code.priv_dir(:kitchenlog)}/templates/recipe.eex", [csrf_token: token, recipe: result])
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page)
  end

  post "/recipe/:id", assigns: %{ fields: [] } do

  end

  get "/recipe/:id/image/:uid", assigns: %{ fields: [] } do
    {:ok, query} = KitchenLog.Repo.query("""
      SELECT lo_get(a.lo) AS content FROM kitchenlog_images AS a
      WHERE reference = $1 AND uid = $2
    """, [id |> String.to_integer, uid])

    result = Enum.map query.rows, fn(row) ->
      Enum.zip(query.columns, row) |> Map.new
    end

    first = result |> List.first
    content = first |> (fn %{"content" => content} -> content end).()
    content_type = "image/jpeg"
    send_resp(conn, 200, "data:#{content_type};base64,#{Base.encode64(content)}")
  end

  post "/recipe/:id/image", assigns: %{ fields: ["image"] } do
    mime = conn.params["image"].content_type
    %{size: size} = File.stat! conn.params["image"].path
    {:ok, query} = KitchenLog.Repo.query("""
      INSERT INTO kitchenlog_images ("reference", "size", "mime")
      VALUES ($1, $2, $3) RETURNING lo
    """, [id |> String.to_integer, size, mime])
    lo = query.rows |> List.first |> List.first
    {:ok, content} = File.read(conn.params["image"].path)
    IO.puts inspect KitchenLog.Repo.query("SELECT lo_put($1, 0, $2)", [lo, content])
    send_resp(conn, 200, "data:#{mime};base64,#{Base.encode64(content)}")
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  defp put_secret_key_base(conn, _) do
    put_in conn.secret_key_base, Application.get_env(:kitchenlog, :secret_key)
  end

  defp put_csrf_token_in_session(conn, _) do
    conn |> put_session("_csrf_token", Plug.CSRFProtection.get_csrf_token)
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    case reason do
      %KitchenLog.Plug.Verify.OutOfContext{} ->
        token = Plug.CSRFProtection.get_csrf_token
        page = EEx.eval_file("#{:code.priv_dir(:kitchenlog)}/templates/index.eex", [csrf_token: token, target: conn.request_path])
        conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page)
      _ ->
        IO.inspect(kind, label: :kind)
        IO.inspect(reason, label: :reason)
        IO.inspect(stack, label: :stack)
        send_resp(conn, conn.status, "Something went wrong")
    end
  end
end
