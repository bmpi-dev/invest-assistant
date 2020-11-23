defmodule InvestApi.PETest do
  use InvestApi.DataCase

  alias InvestApi.PE

  describe "stock_basic" do
    alias InvestApi.PE.StockBasic

    @valid_attrs %{area: "some area", curr_type: "some curr_type", delist_date: ~D[2010-04-17], enname: "some enname", exchange: "some exchange", fullname: "some fullname", industry: "some industry", is_hs: true, list_date: ~D[2010-04-17], list_status: true, market: "some market", name: "some name", symbol: "some symbol", ts_code: "some ts_code"}
    @update_attrs %{area: "some updated area", curr_type: "some updated curr_type", delist_date: ~D[2011-05-18], enname: "some updated enname", exchange: "some updated exchange", fullname: "some updated fullname", industry: "some updated industry", is_hs: false, list_date: ~D[2011-05-18], list_status: false, market: "some updated market", name: "some updated name", symbol: "some updated symbol", ts_code: "some updated ts_code"}
    @invalid_attrs %{area: nil, curr_type: nil, delist_date: nil, enname: nil, exchange: nil, fullname: nil, industry: nil, is_hs: nil, list_date: nil, list_status: nil, market: nil, name: nil, symbol: nil, ts_code: nil}

    def stock_basic_fixture(attrs \\ %{}) do
      {:ok, stock_basic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PE.create_stock_basic()

      stock_basic
    end

    test "list_stock_basic/0 returns all stock_basic" do
      stock_basic = stock_basic_fixture()
      assert PE.list_stock_basic() == [stock_basic]
    end

    test "get_stock_basic!/1 returns the stock_basic with given id" do
      stock_basic = stock_basic_fixture()
      assert PE.get_stock_basic!(stock_basic.id) == stock_basic
    end

    test "create_stock_basic/1 with valid data creates a stock_basic" do
      assert {:ok, %StockBasic{} = stock_basic} = PE.create_stock_basic(@valid_attrs)
      assert stock_basic.area == "some area"
      assert stock_basic.curr_type == "some curr_type"
      assert stock_basic.delist_date == ~D[2010-04-17]
      assert stock_basic.enname == "some enname"
      assert stock_basic.exchange == "some exchange"
      assert stock_basic.fullname == "some fullname"
      assert stock_basic.industry == "some industry"
      assert stock_basic.is_hs == true
      assert stock_basic.list_date == ~D[2010-04-17]
      assert stock_basic.list_status == true
      assert stock_basic.market == "some market"
      assert stock_basic.name == "some name"
      assert stock_basic.symbol == "some symbol"
      assert stock_basic.ts_code == "some ts_code"
    end

    test "create_stock_basic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PE.create_stock_basic(@invalid_attrs)
    end

    test "update_stock_basic/2 with valid data updates the stock_basic" do
      stock_basic = stock_basic_fixture()
      assert {:ok, %StockBasic{} = stock_basic} = PE.update_stock_basic(stock_basic, @update_attrs)
      assert stock_basic.area == "some updated area"
      assert stock_basic.curr_type == "some updated curr_type"
      assert stock_basic.delist_date == ~D[2011-05-18]
      assert stock_basic.enname == "some updated enname"
      assert stock_basic.exchange == "some updated exchange"
      assert stock_basic.fullname == "some updated fullname"
      assert stock_basic.industry == "some updated industry"
      assert stock_basic.is_hs == false
      assert stock_basic.list_date == ~D[2011-05-18]
      assert stock_basic.list_status == false
      assert stock_basic.market == "some updated market"
      assert stock_basic.name == "some updated name"
      assert stock_basic.symbol == "some updated symbol"
      assert stock_basic.ts_code == "some updated ts_code"
    end

    test "update_stock_basic/2 with invalid data returns error changeset" do
      stock_basic = stock_basic_fixture()
      assert {:error, %Ecto.Changeset{}} = PE.update_stock_basic(stock_basic, @invalid_attrs)
      assert stock_basic == PE.get_stock_basic!(stock_basic.id)
    end

    test "delete_stock_basic/1 deletes the stock_basic" do
      stock_basic = stock_basic_fixture()
      assert {:ok, %StockBasic{}} = PE.delete_stock_basic(stock_basic)
      assert_raise Ecto.NoResultsError, fn -> PE.get_stock_basic!(stock_basic.id) end
    end

    test "change_stock_basic/1 returns a stock_basic changeset" do
      stock_basic = stock_basic_fixture()
      assert %Ecto.Changeset{} = PE.change_stock_basic(stock_basic)
    end
  end
end
