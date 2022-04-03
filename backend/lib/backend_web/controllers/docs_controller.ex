defmodule BackendWeb.DocsController do
  use BackendWeb, :controller

  plug :action

  def index(conn, _params) do
    conn
    |> redirect(to: "/docs/backend-api.html")
    |> halt()
  end
end
