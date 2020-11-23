defmodule InvestApi.PE.StockBasic do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "stock_basic" do
    field :area, :string
    field :curr_type, :string
    field :delist_date, :date
    field :enname, :string
    field :exchange, :string
    field :fullname, :string
    field :industry, :string
    field :is_hs, :boolean, default: false
    field :list_date, :date
    field :list_status, :boolean, default: false
    field :market, :string
    field :name, :string
    field :symbol, :string
    field :ts_code, :string

    timestamps()
  end

  @doc false
  def changeset(stock_basic, attrs) do
    stock_basic
    |> cast(attrs, [:ts_code, :symbol, :name, :area, :industry, :fullname, :enname, :market, :exchange, :curr_type, :list_status, :list_date, :delist_date, :is_hs])
    |> validate_required([:ts_code, :symbol, :name, :area, :industry, :fullname, :enname, :market, :exchange, :curr_type, :list_status, :list_date, :delist_date, :is_hs])
    |> unique_constraint(:ts_code)
    |> unique_constraint(:symbol)
  end
end
