defmodule BackendWeb.OrdersController do
  use BackendWeb, :controller

  alias Backend.Order

  action_fallback BackendWeb.FallbackController

  def create(conn, %{"order" => %{"user_id" => username, "items" => product_ids}}) do
    with {:ok, %Order{} = order} <- Backend.create_order(username, product_ids) do
      conn
      |> put_status(:ok)
      |> render("order.json", order: order)
    end
  end
end
