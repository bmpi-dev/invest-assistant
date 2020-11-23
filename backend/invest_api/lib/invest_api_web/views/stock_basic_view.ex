defmodule InvestApiWeb.StockBasicView do
  use InvestApiWeb, :view
  alias InvestApiWeb.StockBasicView

  def render("index.json", %{stock_basic: stock_basic}) do
    %{data: render_many(stock_basic, StockBasicView, "stock_basic.json")}
  end

  def render("show.json", %{stock_basic: stock_basic}) do
    %{data: render_one(stock_basic, StockBasicView, "stock_basic.json")}
  end

  def render("stock_basic.json", %{stock_basic: stock_basic}) do
    %{id: stock_basic.id,
      ts_code: stock_basic.ts_code,
      symbol: stock_basic.symbol,
      name: stock_basic.name,
      area: stock_basic.area,
      industry: stock_basic.industry,
      fullname: stock_basic.fullname,
      enname: stock_basic.enname,
      market: stock_basic.market,
      exchange: stock_basic.exchange,
      curr_type: stock_basic.curr_type,
      list_status: stock_basic.list_status,
      list_date: stock_basic.list_date,
      delist_date: stock_basic.delist_date,
      is_hs: stock_basic.is_hs}
  end
end
