defmodule Backend.Users.Update do
  @moduledoc """
  `Update` commands for users.
  """
  alias Backend.{Repo, User}

  @doc """
  Updates a benefits by `user`.

  Returns `{:ok, %User{}}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Users.Update.benefits(%User{}, 12.0, ["product-1", "product-2"])
    {:ok, %User{}}

  """
  @spec benefits(User.t(), Decimal.t(), [String.t()]) :: {:ok, User.t()} | {:error, String.t()}
  def benefits(%User{} = user, total, product_ids) do
    user
    |> User.changeset(%{
      balance: calculate_balance(user, total),
      product_ids: concatenate_product_ids(user, product_ids)
    })
    |> Repo.update()
  end

  @doc false
  defp calculate_balance(%User{} = user, total), do: Decimal.sub(user.balance, total)

  @doc false
  defp concatenate_product_ids(%User{} = user, product_ids), do: user.product_ids ++ product_ids
end
