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
    case Repo.get(User, username) do
      nil -> Create.by_username(username)
      user -> {:ok, user}
    end
  end
end
