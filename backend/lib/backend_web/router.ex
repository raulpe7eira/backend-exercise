defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackendWeb do
    pipe_through :api

    resources("/users", UsersController, only: [:show], param: "user_id")
  end
end
