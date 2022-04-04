defmodule Backend.ProductTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Backend.Product
  alias Ecto.Changeset

  describe "changeset/2" do
    test "when all fields are valid, returns a valid changeset" do
      fields = build(:product_fields)

      response = Product.changeset(fields)

      assert %Changeset{
               changes: %{
                 id: "ba-ta-ta",
                 name: "Ba Ta Ta",
                 price: %Decimal{coef: 199, exp: -2}
               },
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      fields = build(:product_fields)
      update_fields = %{id: "bt"}

      response =
        fields
        |> Product.changeset()
        |> Product.changeset(update_fields)

      assert %Changeset{
               changes: %{
                 id: "bt",
                 name: "Ba Ta Ta",
                 price: %Decimal{coef: 199, exp: -2}
               },
               valid?: true
             } = response
    end

    test "when there are required error, returns an invalid changeset" do
      fields = build(:product_fields, %{id: nil, name: nil, price: nil})

      response = Product.changeset(fields)

      assert %{
               id: ["can't be blank"],
               name: ["can't be blank"],
               price: ["can't be blank"]
             } = errors_on(response)
    end

    test "when there is an invalid price, returns an invalid changeset" do
      fields = build(:product_fields, %{price: Decimal.new("-1")})

      response = Product.changeset(fields)

      assert %{
               price: ["must be greater than or equal to 0"]
             } = errors_on(response)
    end
  end
end
