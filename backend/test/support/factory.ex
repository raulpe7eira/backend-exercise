defmodule Backend.Factory do
  use ExMachina.Ecto, repo: Backend.Repo

  alias Backend.User

  def user_factory do
    %User{
      username: "raulpe7eira",
      balance: 50_000,
      product_ids: []
    }
  end

  def user_params_factory do
    %{
      username: "raulpe7eira",
      balance: 50_000,
      product_ids: []
    }
  end
end
