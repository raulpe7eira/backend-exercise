defmodule Backend.Factory do
  use ExMachina.Ecto, repo: Backend.Repo

  alias Backend.{Product, User}

  def product_factory do
    %Product{
      id: "ba-ta-ta",
      name: "Batata",
      price: 1.99
    }
  end

  def product_params_factory do
    %{
      id: "ba-ta-ta",
      name: "Batata",
      price: 1.99
    }
  end

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
