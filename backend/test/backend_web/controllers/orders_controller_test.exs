defmodule BackendWeb.OrdersControllerTest do
  use BackendWeb.ConnCase, async: true

  import Backend.Factory

  describe "create/2" do
    setup %{conn: conn} do
      insert(:user)
      insert(:product)

      {:ok, conn: conn}
    end

    test "when all params are valid, creates the order", %{conn: conn} do
      params = build(:order_params)

      response =
        conn
        |> post(Routes.orders_path(conn, :create, params))
        |> json_response(:ok)

      assert %{
               "order" => %{
                 "order_id" => _uuid,
                 "data" => %{
                   "items" => ["ba-ta-ta"],
                   "total" => "1.99"
                 }
               }
             } = response
    end

    test "when there are some error, returns the erro", %{conn: conn} do
      params = %{
        "order" => %{
          "user_id" => "raulpe7eira",
          "items" => ["product-not-found"]
        }
      }

      response =
        conn
        |> post(Routes.orders_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"error" => "products_not_found"} == response
    end
  end
end
