defmodule Backend.Products.List do
  @moduledoc """
  `List` commands for products.
  """
  import Ecto.Query, warn: false

  alias Backend.{Product, Repo}

  @doc """
  Call all products.

  Returns `{:ok, [%Product{}, ...]}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Products.Get.all()
    [%Product{}, ...]

  """
  @spec all :: {:ok, list(Product.t())} | {:error, String.t()}
  def all do
    products =
      Product
      |> Repo.all()

    {:ok, products}
  end

  @doc """
  Call all products in ids range.

  Returns `{:ok, [%Product{}, ...]}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Products.Get.all_in_ids(["prd-1", "prd-2"])
    [%Product{}, ...]

  """
  @spec all_in_ids(list(String.t())) :: {:ok, list(Product.t())} | {:error, String.t()}
  def all_in_ids(ids) do
    products =
      Product
      |> where([product], product.id in ^ids)
      |> Repo.all()

    {:ok, products}
  end
end
