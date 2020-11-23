defmodule InvestApiWeb.StockBasicController do
  use InvestApiWeb, :controller

  alias InvestApi.PE
  alias InvestApi.PE.StockBasic

  action_fallback InvestApiWeb.FallbackController

  def index(conn, _params) do
    stock_basic = PE.list_stock_basic()
    render(conn, "index.json", stock_basic: stock_basic)
  end

  def create(conn, %{"stock_basic" => stock_basic_params}) do
    with {:ok, %StockBasic{} = stock_basic} <- PE.create_stock_basic(stock_basic_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.stock_basic_path(conn, :show, stock_basic))
      |> render("show.json", stock_basic: stock_basic)
    end
  end

  def show(conn, %{"id" => id}) do
    stock_basic = PE.get_stock_basic!(id)
    render(conn, "show.json", stock_basic: stock_basic)
  end

  def update(conn, %{"id" => id, "stock_basic" => stock_basic_params}) do
    stock_basic = PE.get_stock_basic!(id)

    with {:ok, %StockBasic{} = stock_basic} <- PE.update_stock_basic(stock_basic, stock_basic_params) do
      render(conn, "show.json", stock_basic: stock_basic)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock_basic = PE.get_stock_basic!(id)

    with {:ok, %StockBasic{}} <- PE.delete_stock_basic(stock_basic) do
      send_resp(conn, :no_content, "")
    end
  end
end
