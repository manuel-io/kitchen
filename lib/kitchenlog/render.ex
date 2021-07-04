defmodule KitchenLog.Plug.Render do
  import Plug.Conn

  @templates Path.join([:code.priv_dir(:kitchenlog), "templates"])
  @statics Path.join([:code.priv_dir(:kitchenlog), "static"])

  def template(conn, target, assigns) do
    token = Plug.CSRFProtection.get_csrf_token
    conn |> put_session("_csrf_token", Process.get(:plug_unmasked_csrf_token))

    app = %{ "authenticated?": conn |> KitchenLog.Plug.Auth.authenticated?,
             "csrf_token": token # Plug.CSRFProtection.get_csrf_token,
           }

    page = EEx.eval_file(Path.join([@templates, "index.eex"]),
      [ app: app,
        target: target,
      ])

    conn |> put_resp_content_type("text/html") |> send_resp(200, page)
  end

  def target(conn, template, assigns) do
    page = EEx.eval_file(Path.join([@templates, "#{template}.eex"]), assigns)
    conn |> put_resp_content_type("text/html") |> send_resp(200, page)
  end
end
