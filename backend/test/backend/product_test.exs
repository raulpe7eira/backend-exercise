defmodule Backend.ProductTest do
  use Backend.DataCase, async: true

  import Backend.Factory

  alias Ecto.Changeset
  alias Backend.Product

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:product_params)

      response = Product.changeset(params)

      assert %Changeset{
               changes: %{
                 id: "ba-ta-ta",
                 name: "Batata",
                 price: %Decimal{coef: 199, exp: -2}
               },
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:product_params)
      update_params = %{id: "bt"}

      response =
        params
        |> Product.changeset()
        |> Product.changeset(update_params)

      assert %Changeset{
               changes: %{
                 id: "bt",
                 name: "Batata",
                 price: %Decimal{coef: 199, exp: -2}
               },
               valid?: true
             } = response
    end

    test "when there are required error, returns an invalid changeset" do
      params = build(:product_params, %{id: nil, name: nil, price: nil})

      response = Product.changeset(params)

      assert %{
               id: ["can't be blank"],
               name: ["can't be blank"],
               price: ["can't be blank"]
             } = errors_on(response)
    end

    test "when there is an invalid price, returns an invalid changeset" do
      params = build(:product_params, %{price: Decimal.new("-1")})

      response = Product.changeset(params)

      assert %{
               price: ["must be greater than or equal to 0"]
             } = errors_on(response)
    end
  end
end
