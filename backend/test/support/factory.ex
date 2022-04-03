defmodule Backend.Factory do
  use ExMachina.Ecto, repo: Backend.Repo

  alias Backend.{Order, Product, User}

  def order_factory do
    %Order{
      id: Ecto.UUID.generate(),
      total: Decimal.from_float(1.99),
      user_id: "raulpe7eira",
      items: [build(:product)]
    }
  end

  def order_fields_factory do
    %{
      total: Decimal.from_float(1.99),
      user_id: "raulpe7eira",
      items: [build(:product)]
    }
  end

  def order_params_factory do
    %{
      "order" => %{
        "user_id" => "raulpe7eira",
        "items" => ["ba-ta-ta"]
      }
    }
  end

  def product_factory do
    %Product{
      id: "ba-ta-ta",
      name: "Ba Ta Ta",
      price: Decimal.from_float(1.99)
    }
  end

  def product_fields_factory do
    %{
      id: "ba-ta-ta",
      name: "Ba Ta Ta",
      price: Decimal.from_float(1.99)
    }
  end

  def user_factory do
    %User{
      username: "raulpe7eira",
      balance: Decimal.from_float(199.1),
      product_ids: []
    }
  end

  def user_fields_factory do
    %{
      username: "raulpe7eira",
      balance: Decimal.from_float(199.1),
      product_ids: []
    }
  end
end
