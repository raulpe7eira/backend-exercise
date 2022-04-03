defmodule Backend.Users.Get do
  @moduledoc """
  `Get` commands for users.
  """
  import Ecto.Query, warn: false

  alias Backend.{Repo, User, Users.Create}

  @doc """
  Gets an user or creates if it doesn't finds one by `username`.

  Returns `{:ok, %User{}}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Users.Get.or_create_by_username("raulpe7eira")
    {:ok, %User{}}

  """
  @spec or_create_by_username(String.t()) :: {:ok, User.t()} | {:error, String.t()}
  def or_create_by_username(username) when is_binary(username) do
    case by_username(username) do
      {:error, _reason} -> Create.by_username(username)
      user -> user
    end
  end

  @doc """
  Gets an user by `username`.

  Returns `{:ok, %User{}}` or `{:error, "reason"}`

  ### Examples

    iex> Backend.Users.Get.by_username("raulpe7eira")
    {:ok, %User{}}

  """
  @spec by_username(String.t()) :: {:ok, Product.t()} | {:error, String.t()}
  def by_username(username) when is_binary(username) do
    case Repo.one(from(u in User, where: u.username == ^username, preload: [:orders])) do
      nil -> {:error, "user_not_found"}
      user -> {:ok, user}
    end
  end
end
