defmodule Backend.Products.List do
  @moduledoc """
  `List` commands for products.
  """
  import Ecto.Query, warn: false

  alias Backend.{Repo, Product}

  @doc """
  Call all products.

  Returns `{:ok, [%Product{}, ...]}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Products.Get.all()
    [%Product{}, ...]

  """
  @spec all() :: {:ok, list(Product.t())} | {:error, String.t()}
  def all(), do: {:ok, Repo.all(Product)}
end
