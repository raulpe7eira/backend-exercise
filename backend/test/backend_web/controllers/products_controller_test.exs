defmodule BackendWeb.ProductsControllerTest do
  use BackendWeb.ConnCase, async: true

  import Backend.Factory

  describe "index/2" do
    test "when there are products, show list of products", %{conn: conn} do
      insert(:product)

      response =
        conn
        |> get(Routes.products_path(conn, :index))
        |> json_response(:ok)

      assert %{
               "products" => [
                 %{
                   "id" => "ba-ta-ta",
                   "name" => "Ba Ta Ta",
                   "price" => "1.99"
                 }
               ]
             } == response
    end

    test "when there are no products, show empty list", %{conn: conn} do
      response =
        conn
        |> get(Routes.products_path(conn, :index))
        |> json_response(:ok)

      assert %{"products" => []} == response
    end
  end
end
