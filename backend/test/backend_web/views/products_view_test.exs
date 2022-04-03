defmodule BackendWeb.ProductsViewTest do
  use BackendWeb.ConnCase, async: true

  import Phoenix.View
  import Backend.Factory

  alias BackendWeb.ProductsView

  test "renders products.json" do
    products = [build(:product), build(:product)]

    response = render(ProductsView, "products.json", products: products)

    assert %{
             products: [
               %{
                 id: "ba-ta-ta",
                 name: "Ba Ta Ta",
                 price: %Decimal{coef: 199, exp: -2}
               },
               %{
                 id: "ba-ta-ta",
                 name: "Ba Ta Ta",
                 price: %Decimal{coef: 199, exp: -2}
               }
             ]
           } == response
  end

  test "renders product.json" do
    product = build(:product)

    response = render(ProductsView, "product.json", product: product)

    assert %{
             id: "ba-ta-ta",
             name: "Ba Ta Ta",
             price: %Decimal{coef: 199, exp: -2}
           } == response
  end
end
