defmodule Backend.User do
  @moduledoc """
  Schema for `users`.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{}

  @derive {Jason.Encoder, only: [:username, :balance, :product_ids]}

  @required_fields [:username, :balance, :product_ids]
  @optional_fields []

  @primary_key false
  schema "users" do
    field :username, :string, primary_key: true
    field :balance, :decimal, null: false
    field :product_ids, {:array, :string}, default: []

    timestamps()
  end

  @doc false
  def changeset(data \\ %__MODULE__{}, fields) do
    data
    |> cast(fields, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:balance, greater_than_or_equal_to: 0)
  end
end
