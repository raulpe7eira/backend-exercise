defmodule BackendWeb.OrdersView do
  use BackendWeb, :view

  alias Backend.Order

  def render("order.json", %{order: %Order{} = order}) do
    %{
      order: %{
        order_id: order.id,
        data: %{
          items: Enum.map(order.items, & &1.id),
          total: order.total
        }
      }
    }
  end
end
