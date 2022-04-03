defmodule BackendWeb.ProductsView do
  use BackendWeb, :view

  alias Backend.Product

  def render("products.json", %{products: products}) do
    %{products: render_many(products, __MODULE__, "product.json", as: :product)}
  end

  def render("product.json", %{product: %Product{} = product}) do
    %{
      id: product.id,
      name: product.name,
      price: product.price
    }
  end
end
