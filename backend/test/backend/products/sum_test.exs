defmodule Backend.Products.SumTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.Products.Sum

  describe "product_prices/1" do
    test "when list products empty, returns zero" do
      response = Sum.product_prices([])

      assert {:ok, 0.0} = response
    end

    test "when list products no empty, returns sum of price" do
      products = [build(:product), build(:product)]

      response = Sum.product_prices(products)

      assert {:ok, %Decimal{coef: 398, exp: -2}} = response
    end
  end
end
