defmodule InvestApi.Repo.Migrations.CreateStockBasic do
  use Ecto.Migration

  def change do
    create table(:stock_basic, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :ts_code, :string
      add :symbol, :string
      add :name, :string
      add :area, :string
      add :industry, :string
      add :fullname, :string
      add :enname, :string
      add :market, :string
      add :exchange, :string
      add :curr_type, :string
      add :list_status, :boolean, default: false, null: false
      add :list_date, :date
      add :delist_date, :date
      add :is_hs, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:stock_basic, [:ts_code])
    create unique_index(:stock_basic, [:symbol])
  end
end
