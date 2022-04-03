defmodule Backend.Users.CreateTest do
  use Backend.DataCase, async: true

  alias Backend.{User, Users.Create}

  @username "raulpe7eira"

  describe "by_username/1" do
    test "when all params are valid, returns the user" do
      response = Create.by_username(@username)

      assert {
               :ok,
               %User{
                 username: @username,
                 balance: %Decimal{coef: 50_000},
                 product_ids: []
               }
             } = response
    end

    test "when there are invalid params, returns an error" do
      response = Create.by_username("")

      assert {:error, changeset} = response
      assert %{username: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
