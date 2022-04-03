defmodule Backend.Users.Create do
  @moduledoc """
  `Create` commands for users.
  """
  alias Backend.{Repo, User}

  @initial_balance 50_000

  @doc """
  Creates an user by `username`.

  Returns `{:ok, %User{}}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Users.Create.by_username("raulpe7eira")
    {:ok, %User{}}

  """
  @spec by_username(String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def by_username(username) when is_binary(username) do
    %User{}
    |> User.changeset(%{username: username, balance: @initial_balance, product_ids: []})
    |> Repo.insert()
  end
end
