defmodule Backend.Products.ListTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.{Product, Products.List}

  describe "all/0" do
    test "when there are products, show list of products" do
      insert(:product)

      response = List.all()

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
      response = List.all()

      assert {:ok, []} = response
    end
  end
end
