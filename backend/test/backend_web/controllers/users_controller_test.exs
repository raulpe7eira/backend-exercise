defmodule BackendWeb.UsersControllerTest do
  use BackendWeb.ConnCase, async: true

  import Backend.Factory

  @username "raulpe7eira"

  describe "show/2" do
    test "when there is an user with the given username, show the user found", %{conn: conn} do
      insert(:user)

      response =
        conn
        |> get(Routes.users_path(conn, :show, @username))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "data" => %{
                   "balance" => "50000",
                   "product_ids" => []
                 },
                 "user_id" => @username
               }
             } == response
    end

    test "when there isn't an user with the given username, show the user created", %{conn: conn} do
      response =
        conn
        |> get(Routes.users_path(conn, :show, @username))
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "data" => %{
                   "balance" => "50000",
                   "product_ids" => []
                 },
                 "user_id" => @username
               }
             } == response
    end
  end
end
