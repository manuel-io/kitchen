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

  plug Plug.Static, at: "/static", from: "#{:code.priv_dir(:kitchenlog)}/static"
  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug KitchenLog.Plug.Verify, fields: ["image"], size: 5242880, types: ["image/jpeg", "image/png"]
  plug :match
  plug :dispatch

  get "/" do
    # IO.puts inspect :code.priv_dir(:kitchenlog)
    token = Plug.CSRFProtection.get_csrf_token
    page_contents = EEx.eval_file("#{:code.priv_dir(:kitchenlog)}/templates/index.eex", [csrf_token: token])
    conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200, page_contents)
  end

  post "/image" do
    # IO.puts inspect KitchenLog.Repo.query("SELECT id FROM minicloud_multimedia LIMIT 1", [])
    {:ok, content} = File.read(conn.params["image"].path)
    content_type = conn.params["image"].content_type
    send_resp(conn, 200, "data:#{content_type};base64,#{Base.encode64(content)}")
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
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end
end
