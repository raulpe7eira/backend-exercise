defmodule BackendTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.{Order, Product, User}

  @username "raulpe7eira"

  describe "get_user_or_create/1" do
    test "when there is an user with the given username, show the user found" do
      insert(:user)

      response = Backend.get_user_or_create(@username)

      assert {
               :ok,
               %User{
                 username: @username,
                 balance: %Decimal{coef: 1991, exp: -1},
                 product_ids: [],
                 inserted_at: _inserted_at,
                 updated_at: _updated_at
               }
             } = response
    end

    test "when there isn't an user with the given username, show the user created" do
      response = Backend.get_user_or_create(@username)

      assert {
               :ok,
               %User{
                 username: @username,
                 balance: %Decimal{coef: 50_000},
                 product_ids: [],
                 inserted_at: _inserted_at,
                 updated_at: _updated_at
               }
             } = response
    end
  end

  describe "list_products/0" do
    test "when there are products, show list of products" do
      insert(:product)

      response = Backend.list_products()

      assert {
               :ok,
               [
                 %Product{
                   id: "ba-ta-ta",
                   name: "Ba Ta Ta",
                   price: %Decimal{coef: 199, exp: -2}
                 }
               ]
             } = response
    end

    test "when there are no products, show empty list" do
      response = Backend.list_products()

      assert {:ok, []} = response
    end
  end

  describe "create_order/2" do
    test "when all fields are valid, creates the order" do
      insert(:user)
      insert(:product)

      response = Backend.create_order(@username, ["ba-ta-ta"])

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

      response = Backend.create_order(@username, ["product-not-found"])

      assert {:error, "products_not_found"} = response
    end

    test "when there is product already purchased, returns the erro" do
      insert(:user, product_ids: ["ba-ta-ta"])
      insert(:product)

      response = Backend.create_order(@username, ["ba-ta-ta"])

      assert {:error, "products_already_purchased"} = response
    end

    test "when there is insufficient balance, returns the erro" do
      insert(:user, balance: 1)
      insert(:product)

      response = Backend.create_order(@username, ["ba-ta-ta"])

      assert {:error, "insufficient_balance"} = response
    end
  end
end
