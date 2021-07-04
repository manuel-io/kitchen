defmodule KitchenLog.Repo do
  use Ecto.Repo,
    otp_app: :kitchenlog,
    adapter: Ecto.Adapters.Postgres

  defmodule DBError do
    defexception message: "DBError", plug_status: 400
  end

  def fetchall(query) do
    Enum.map query.rows, fn(row) ->
      Enum.zip(query.columns, row) |> Map.new
    end
  end

  def fetchone(query) do
    case query.rows do
      [] -> %{}
      _ -> query.columns |> Enum.zip(query.rows |> List.first) |> Map.new
    end
  end
end
