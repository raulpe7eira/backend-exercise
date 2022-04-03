defmodule Backend.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:username, :string, primary_key: true)
      add(:balance, :decimal, null: false)
      add(:product_ids, {:array, :string}, null: false, default: [])

      timestamps()
    end

    create(constraint(:users, :balance_must_be_positive, check: "balance >= 0.0"))
  end
end
