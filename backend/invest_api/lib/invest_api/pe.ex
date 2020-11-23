defmodule InvestApi.PE do
  @moduledoc """
  The PE context.
  """

  import Ecto.Query, warn: false
  alias InvestApi.Repo

  alias InvestApi.PE.StockBasic

  @doc """
  Returns the list of stock_basic.

  ## Examples

      iex> list_stock_basic()
      [%StockBasic{}, ...]

  """
  def list_stock_basic do
    Repo.all(StockBasic)
  end

  @doc """
  Gets a single stock_basic.

  Raises `Ecto.NoResultsError` if the Stock basic does not exist.

  ## Examples

      iex> get_stock_basic!(123)
      %StockBasic{}

      iex> get_stock_basic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock_basic!(id), do: Repo.get!(StockBasic, id)

  @doc """
  Creates a stock_basic.

  ## Examples

      iex> create_stock_basic(%{field: value})
      {:ok, %StockBasic{}}

      iex> create_stock_basic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock_basic(attrs \\ %{}) do
    %StockBasic{}
    |> StockBasic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock_basic.

  ## Examples

      iex> update_stock_basic(stock_basic, %{field: new_value})
      {:ok, %StockBasic{}}

      iex> update_stock_basic(stock_basic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock_basic(%StockBasic{} = stock_basic, attrs) do
    stock_basic
    |> StockBasic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a stock_basic.

  ## Examples

      iex> delete_stock_basic(stock_basic)
      {:ok, %StockBasic{}}

      iex> delete_stock_basic(stock_basic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock_basic(%StockBasic{} = stock_basic) do
    Repo.delete(stock_basic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock_basic changes.

  ## Examples

      iex> change_stock_basic(stock_basic)
      %Ecto.Changeset{data: %StockBasic{}}

  """
  def change_stock_basic(%StockBasic{} = stock_basic, attrs \\ %{}) do
    StockBasic.changeset(stock_basic, attrs)
  end
end
