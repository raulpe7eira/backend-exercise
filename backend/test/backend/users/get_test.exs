defmodule Backend.Users.GetTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.{User, Users.Get}

  @username "raulpe7eira"

  describe "or_create_by_username/1" do
    test "when there is an user with the given username, returns the user" do
      insert(:user)

      response = Get.or_create_by_username(@username)

      assert {
               :ok,
               %User{
                 username: @username,
                 balance: %Decimal{coef: 1991, exp: -1},
                 product_ids: []
               }
             } = response
    end

    test "when there isn't an user with the given username, returns the user" do
      response = Get.or_create_by_username(@username)

      assert {
               :ok,
               %User{
                 username: @username,
                 balance: %Decimal{coef: 50_000},
                 product_ids: []
               }
             } = response
    end

    test "when there are invalid fields, returns an error" do
      response = Get.or_create_by_username("")

      assert {:error, changeset} = response
      assert %{username: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
