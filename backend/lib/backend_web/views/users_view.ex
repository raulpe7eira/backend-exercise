defmodule BackendWeb.UsersView do
  use BackendWeb, :view

  alias Backend.User

  def render("user.json", %{user: %User{} = user}) do
    %{
      user: %{
        user_id: user.username,
        data: %{
          balance: user.balance,
          product_ids: user.product_ids
        }
      }
    }
  end
end
