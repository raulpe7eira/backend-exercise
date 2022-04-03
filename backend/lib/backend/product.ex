defmodule Backend.Product do
  @moduledoc """
  Schema for `products`.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  @derive {Jason.Encoder, only: [:id, :name, :price]}

  @required_fields [:id, :name, :price]
  @optional_fields []

  @primary_key false
  schema "products" do
    field :id, :string, primary_key: true
    field :name, :string, null: false
    field :price, :decimal, null: false

    timestamps()
  end

  @doc false
  def changeset(data \\ %__MODULE__{}, fields) do
    data
    |> cast(fields, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:price, greater_than_or_equal_to: 0)
  end
end
