defmodule BackendWeb.FallbackController do
  use BackendWeb, :controller

  def call(conn, {:error, reason}) when is_binary(reason) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: reason})
  end
end
