defmodule BackendWeb.Router do
  use BackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackendWeb do
    pipe_through :api

    resources "/users", UsersController, only: [:show], param: "user_id"
    resources "/products", ProductsController, only: [:index]
    resources "/orders", OrdersController, only: [:create]
  end

  if Mix.env() in [:dev, :test] do
    pipeline :browser do
      plug :accepts, ["html"]
      plug :put_secure_browser_headers
    end

    scope "/docs", BackendWeb do
      pipe_through :browser

      resources "/", DocsController, only: [:index]
    end
  end
end
