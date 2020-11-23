defmodule InvestApi.Repo do
  use Ecto.Repo,
    otp_app: :invest_api,
    adapter: Ecto.Adapters.Postgres
end
