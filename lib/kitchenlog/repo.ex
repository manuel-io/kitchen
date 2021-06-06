defmodule KitchenLog.Repo do
  use Ecto.Repo,
    otp_app: :kitchenlog,
    adapter: Ecto.Adapters.Postgres
end
