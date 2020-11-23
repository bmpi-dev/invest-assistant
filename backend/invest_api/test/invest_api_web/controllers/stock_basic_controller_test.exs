defmodule InvestApiWeb.StockBasicControllerTest do
  use InvestApiWeb.ConnCase

  alias InvestApi.PE
  alias InvestApi.PE.StockBasic

  @create_attrs %{
    area: "some area",
    curr_type: "some curr_type",
    delist_date: ~D[2010-04-17],
    enname: "some enname",
    exchange: "some exchange",
    fullname: "some fullname",
    industry: "some industry",
    is_hs: true,
    list_date: ~D[2010-04-17],
    list_status: true,
    market: "some market",
    name: "some name",
    symbol: "some symbol",
    ts_code: "some ts_code"
  }
  @update_attrs %{
    area: "some updated area",
    curr_type: "some updated curr_type",
    delist_date: ~D[2011-05-18],
    enname: "some updated enname",
    exchange: "some updated exchange",
    fullname: "some updated fullname",
    industry: "some updated industry",
    is_hs: false,
    list_date: ~D[2011-05-18],
    list_status: false,
    market: "some updated market",
    name: "some updated name",
    symbol: "some updated symbol",
    ts_code: "some updated ts_code"
  }
  @invalid_attrs %{area: nil, curr_type: nil, delist_date: nil, enname: nil, exchange: nil, fullname: nil, industry: nil, is_hs: nil, list_date: nil, list_status: nil, market: nil, name: nil, symbol: nil, ts_code: nil}

  def fixture(:stock_basic) do
    {:ok, stock_basic} = PE.create_stock_basic(@create_attrs)
    stock_basic
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all stock_basic", %{conn: conn} do
      conn = get(conn, Routes.stock_basic_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create stock_basic" do
    test "renders stock_basic when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stock_basic_path(conn, :create), stock_basic: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.stock_basic_path(conn, :show, id))

      assert %{
               "id" => id,
               "area" => "some area",
               "curr_type" => "some curr_type",
               "delist_date" => "2010-04-17",
               "enname" => "some enname",
               "exchange" => "some exchange",
               "fullname" => "some fullname",
               "industry" => "some industry",
               "is_hs" => true,
               "list_date" => "2010-04-17",
               "list_status" => true,
               "market" => "some market",
               "name" => "some name",
               "symbol" => "some symbol",
               "ts_code" => "some ts_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stock_basic_path(conn, :create), stock_basic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update stock_basic" do
    setup [:create_stock_basic]

    test "renders stock_basic when data is valid", %{conn: conn, stock_basic: %StockBasic{id: id} = stock_basic} do
      conn = put(conn, Routes.stock_basic_path(conn, :update, stock_basic), stock_basic: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.stock_basic_path(conn, :show, id))

      assert %{
               "id" => id,
               "area" => "some updated area",
               "curr_type" => "some updated curr_type",
               "delist_date" => "2011-05-18",
               "enname" => "some updated enname",
               "exchange" => "some updated exchange",
               "fullname" => "some updated fullname",
               "industry" => "some updated industry",
               "is_hs" => false,
               "list_date" => "2011-05-18",
               "list_status" => false,
               "market" => "some updated market",
               "name" => "some updated name",
               "symbol" => "some updated symbol",
               "ts_code" => "some updated ts_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, stock_basic: stock_basic} do
      conn = put(conn, Routes.stock_basic_path(conn, :update, stock_basic), stock_basic: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete stock_basic" do
    setup [:create_stock_basic]

    test "deletes chosen stock_basic", %{conn: conn, stock_basic: stock_basic} do
      conn = delete(conn, Routes.stock_basic_path(conn, :delete, stock_basic))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.stock_basic_path(conn, :show, stock_basic))
      end
    end
  end

  defp create_stock_basic(_) do
    stock_basic = fixture(:stock_basic)
    %{stock_basic: stock_basic}
  end
end
