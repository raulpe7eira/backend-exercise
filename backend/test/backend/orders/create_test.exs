defmodule Backend.Orders.CreateTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.{Order, Orders.Create, Product}

  @username "raulpe7eira"

  describe "by_username/2" do
    test "when all fields are valid, returns the order" do
      insert(:user, product_ids: ["ba-ta-ta-2"])
      insert(:product)

      response = Create.by_username(@username, ["ba-ta-ta"])

      assert {
               :ok,
               %Order{
                 id: _id,
                 total: %Decimal{coef: 199, exp: -2},
                 items: [%Product{id: "ba-ta-ta"}],
                 inserted_at: _inserted_at,
                 updated_at: _updated_at
               }
             } = response
    end

    test "when there is product not found, returns the erro" do
      insert(:user)
      insert(:product)

      response = Create.by_username(@username, ["product-not-found"])

      assert {:error, "products_not_found"} = response
    end

    test "when there is product already purchased, returns the erro" do
      insert(:user, product_ids: ["ba-ta-ta"])
      insert(:product)

      response = Create.by_username(@username, ["ba-ta-ta"])

      assert {:error, "products_already_purchased"} = response
    end

    test "when there is insufficient balance, returns the erro" do
      insert(:user, balance: 1)
      insert(:product)

      response = Create.by_username(@username, ["ba-ta-ta"])

      assert {:error, "insufficient_balance"} = response
    end
  end
end
