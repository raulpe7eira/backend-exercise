defmodule Backend.UserTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.User
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all fields are valid, returns a valid changeset" do
      fields = build(:user_fields)

      response = User.changeset(fields)

      assert %Changeset{
               changes: %{
                 balance: %Decimal{coef: 1991, exp: -1},
                 username: "raulpe7eira"
               },
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      fields = build(:user_fields)
      update_fields = %{username: "rp"}

      response =
        fields
        |> User.changeset()
        |> User.changeset(update_fields)

      assert %Changeset{
               changes: %{
                 balance: %Decimal{coef: 1991, exp: -1},
                 username: "rp"
               },
               valid?: true
             } = response
    end

    test "when there are required error, returns an invalid changeset" do
      fields = build(:user_fields, %{username: nil, balance: nil, product_ids: nil})

      response = User.changeset(fields)

      assert %{
               username: ["can't be blank"],
               balance: ["can't be blank"],
               product_ids: ["can't be blank"]
             } = errors_on(response)
    end

    test "when there is an invalid balance, returns an invalid changeset" do
      fields = build(:user_fields, %{balance: Decimal.new("-1")})

      response = User.changeset(fields)

      assert %{
               balance: ["must be greater than or equal to 0"]
             } = errors_on(response)
    end
  end
end
