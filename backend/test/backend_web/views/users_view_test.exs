defmodule BackendWeb.UsersViewTest do
  use BackendWeb.ConnCase, async: true

  import Phoenix.View
  import Backend.Factory

  alias BackendWeb.UsersView

  test "renders user.json" do
    user = build(:user)

    response = render(UsersView, "user.json", user: user)

    assert %{
             user: %{
               user_id: "raulpe7eira",
               data: %{
                 balance: %Decimal{coef: 1991, exp: -1},
                 product_ids: []
               }
             }
           } == response
  end
end
