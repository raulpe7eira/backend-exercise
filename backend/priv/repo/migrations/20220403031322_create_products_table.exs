defmodule Backend.Repo.Migrations.CreateProductsTable do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :string, primary_key: true
      add :name, :string, null: false
      add :price, :decimal, null: false

      timestamps()
    end

    create constraint(:products, :price_must_be_positive, check: "price >= 0.0")
  end
end
