defmodule KitchenLog.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      { Plug.Cowboy, scheme: :http, plug: KitchenLog.Router, options:
        [ ip: cowboy_interface(),
          port: cowboy_port()
        ]
      },
      { KitchenLog.Repo, [] }
    ]
    opts = [strategy: :one_for_one, name: KitchenLog.Supervisor]

    Logger.info("Starting application...")
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:kitchenlog, :cowboy_port, 8080)
  defp cowboy_interface, do: Application.get_env(:kitchenlog, :cowboy_interface, {127, 0, 0, 1})
end
