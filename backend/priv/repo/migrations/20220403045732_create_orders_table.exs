defmodule Backend.Repo.Migrations.CreateOrdersTable do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :total, :decimal, null: false
      add :user_id, references(:users, column: :username, type: :string), null: false
      add :items, {:array, :jsonb}, null: false

      timestamps()
    end

    create constraint(:orders, :total_must_be_positive, check: "total >= 0.0")
    create index(:orders, [:user_id])
  end
end
