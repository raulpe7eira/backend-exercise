defmodule BackendWeb.UsersController do
  use BackendWeb, :controller

  alias Backend.User

  action_fallback BackendWeb.FallbackController

  def show(conn, %{"user_id" => username}) do
    with {:ok, %User{} = user} <- Backend.get_user_or_create(username) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end
end
