defmodule Backend.UserTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Ecto.Changeset
  alias Backend.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{
               changes: %{
                 balance: %Decimal{coef: 50_000},
                 username: "raulpe7eira"
               },
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)
      update_params = %{username: "rp"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{
               changes: %{
                 balance: %Decimal{coef: 50_000},
                 username: "rp"
               },
               valid?: true
             } = response
    end

    test "when there are required error, returns an invalid changeset" do
      params = build(:user_params, %{username: nil, balance: nil, product_ids: nil})

      response = User.changeset(params)

      assert %{
               username: ["can't be blank"],
               balance: ["can't be blank"],
               product_ids: ["can't be blank"]
             } = errors_on(response)
    end

    test "when there is an invalid balance, returns an invalid changeset" do
      params = build(:user_params, %{balance: Decimal.new("-1")})

      response = User.changeset(params)

      assert %{
               balance: ["must be greater than or equal to 0"]
             } = errors_on(response)
    end
  end
end
