defmodule Backend.OrderTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.Order
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all fields are valid, returns a valid changeset" do
      fields = build(:order_fields)

      response = Order.changeset(fields)

      assert %Changeset{
               changes: %{
                 total: %Decimal{coef: 199, exp: -2},
                 user_id: "raulpe7eira",
                 items: [
                   %Changeset{
                     changes: %{
                       id: "ba-ta-ta",
                       name: "Ba Ta Ta",
                       price: %Decimal{coef: 199, exp: -2}
                     },
                     valid?: true
                   }
                 ]
               },
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      fields = build(:order_fields)
      update_fields = %{total: Decimal.new("1.98")}

      response =
        fields
        |> Order.changeset()
        |> Order.changeset(update_fields)

      assert %Changeset{
               changes: %{
                 total: %Decimal{coef: 198, exp: -2},
                 user_id: "raulpe7eira",
                 items: [
                   %Changeset{
                     changes: %{
                       id: "ba-ta-ta",
                       name: "Ba Ta Ta",
                       price: %Decimal{coef: 199, exp: -2}
                     },
                     valid?: true
                   }
                 ]
               },
               valid?: true
             } = response
    end

    test "when there are required error, returns an invalid changeset" do
      fields = build(:order_fields, %{total: nil, user_id: nil})

      response = Order.changeset(fields)

      assert %{
               total: ["can't be blank"],
               user_id: ["can't be blank"]
             } = errors_on(response)
    end

    test "when there is an invalid total, returns an invalid changeset" do
      fields = build(:order_fields, %{total: Decimal.new("-1")})

      response = Order.changeset(fields)

      assert %{
               total: ["must be greater than or equal to 0"]
             } = errors_on(response)
    end
  end
end
