defmodule BackendTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.User

  @username "raulpe7eira"

  describe "get_user_or_create/1" do
    test "when there is an user with the given username, show the user found" do
      insert(:user)

      response = Backend.get_user_or_create(@username)

      assert {:ok,
              %User{
                username: @username,
                balance: %Decimal{coef: 50_000},
                product_ids: [],
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "when there isn't an user with the given username, show the user created" do
      response = Backend.get_user_or_create(@username)

      assert {:ok,
              %User{
                username: @username,
                balance: %Decimal{coef: 50_000},
                product_ids: [],
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end
  end
end
