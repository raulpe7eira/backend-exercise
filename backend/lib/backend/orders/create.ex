defmodule Backend.Orders.Create do
  @moduledoc """
  `Create` commands for orders.
  """
  alias Backend.{Order, Repo, User}
  alias Backend.Products.List, as: ProductList
  alias Backend.Products.Sum, as: ProductSum
  alias Backend.Users.Get, as: UserGet
  alias Backend.Users.Update, as: UserUpdate

  require Logger

  @doc """
  Creates an order by `username`.

  Returns `{:ok, %Order{}}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Orders.Create.by_username("raulpe7eira", ["product-1", "product-2"])
    {:ok, %Order{}}

  """
  @spec by_username(String.t(), list(String.t())) :: {:ok, Order.t()} | {:error, String.t()}
  def by_username(username, product_ids) when is_binary(username) do
    Logger.metadata(username: username, product_ids: product_ids)

    product_ids = remove_duplicated_products(product_ids)

    Repo.transaction(fn ->
      with {:ok, products} <- ProductList.all_in_ids(product_ids),
           :ok <- verify_products_not_found(products, product_ids),
           {:ok, user} <- UserGet.by_username(username),
           :ok <- verify_products_already_purchased(products, user.product_ids),
           {:ok, total} <- ProductSum.product_prices(products),
           :ok <- verify_insufficient_balance(total, user.balance),
           {:ok, order} <- create_order(total, user, products),
           {:ok, _user} <- UserUpdate.benefits(user, total, product_ids) do
        order
      else
        {:error, reason} ->
          Logger.info("Failed to create the order", reason: inspect(reason))
          Repo.rollback(reason)
      end
    end)
  end

  @doc false
  defp remove_duplicated_products(products), do: Enum.uniq(products)

  @doc false
  defp verify_products_not_found(found_products, order_products)

  defp verify_products_not_found(found_products, order_products)
       when length(found_products) == length(order_products),
       do: :ok

  defp verify_products_not_found(_, _), do: {:error, "products_not_found"}

  @doc false
  defp verify_products_already_purchased(order_products, purchased_products)

  defp verify_products_already_purchased(order_products, purchased_products)
       when order_products == [] or purchased_products == [],
       do: :ok

  defp verify_products_already_purchased(order_products, purchased_products) do
    order_product_ids = Enum.map(order_products, & &1.id)

    purchased_products
    |> Enum.find(&Enum.member?(order_product_ids, &1))
    |> case do
      nil -> :ok
      _ -> {:error, "products_already_purchased"}
    end
  end

  @doc false
  defp verify_insufficient_balance(order_total, balance)
  defp verify_insufficient_balance(order_total, balance) when order_total <= balance, do: :ok
  defp verify_insufficient_balance(_, _), do: {:error, "insufficient_balance"}

  @doc false
  defp create_order(total, %User{} = user, products) do
    %Order{}
    |> Order.changeset(%{total: total, user_id: user.username, items: products})
    |> Repo.insert()
  end
end
