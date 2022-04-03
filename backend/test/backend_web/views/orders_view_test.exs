defmodule BackendWeb.OrdersViewTest do
  use BackendWeb.ConnCase, async: true

  import Phoenix.View
  import Backend.Factory

  alias BackendWeb.OrdersView

  test "renders order.json" do
    order = build(:order)

    response = render(OrdersView, "order.json", order: order)

    assert %{
             order: %{
               order_id: _id,
               data: %{
                 items: ["ba-ta-ta"],
                 total: %Decimal{coef: 199, exp: -2}
               }
             }
           } = response
  end
end
