defmodule Backend.Products.Sum do
  @moduledoc """
  `Sum` commands for products.
  """

  @doc """
  Sums all the prices from `products`.

  Returns `{:ok, 0.0}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Products.Sum.product_prices([])
    {:ok, 0.0}

    iex> Backend.Products.Sum.product_prices([%Product{price: 1.2}, %Product{price: 1.23}])
    {:ok, 2.43}

  """
  @spec product_prices([Product.t()]) :: {:ok, Decimal.t()} | {:error, String.t()}
  def product_prices(products)

  def product_prices([]), do: {:ok, 0.0}

  def product_prices(products) do
    products =
      products
      |> Enum.map(& &1.price)
      |> Enum.reduce(Decimal.new("0.0"), &Decimal.add(&1, &2))

    {:ok, products}
  end
end
