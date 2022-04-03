defmodule BackendWeb.ProductsController do
  use BackendWeb, :controller

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    with {:ok, products} <- Backend.list_products() do
      conn
      |> put_status(:ok)
      |> render("products.json", products: products)
    end
  end
end
