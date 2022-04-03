defmodule Backend.Order do
  @moduledoc """
  Schema for `orders`.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.Product

  @type t() :: %__MODULE__{}

  @derive {Jason.Encoder, only: [:id, :total, :user_id, :items]}

  @required_fields [:total, :user_id]
  @optional_fields []

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :total, :decimal, null: false
    field :user_id, :string, null: false

    embeds_many :items, Product

    timestamps()
  end

  @doc false
  def changeset(data \\ %__MODULE__{}, fields) do
    data
    |> cast(fields, @required_fields ++ @optional_fields)
    |> cast_embed(:items, required: true, with: {Product, :cast_as_order_item, []})
    |> validate_required(@required_fields)
    |> validate_number(:total, greater_than_or_equal_to: 0)
  end
end
