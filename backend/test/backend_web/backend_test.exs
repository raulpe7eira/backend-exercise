defmodule BackendTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.{Product, User}

  @username "raulpe7eira"

  describe "get_user_or_create/1" do
    test "when there is an user with the given username, show the user found" do
      insert(:user)

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
                   name: "Batata",
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
end
