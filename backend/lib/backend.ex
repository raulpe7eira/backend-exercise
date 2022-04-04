defmodule Backend do
  @moduledoc """
  Backend keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Backend.Orders.Create, as: OrderCreate
  alias Backend.Products.List, as: ProductList
  alias Backend.Users.Get, as: UserGet

  defdelegate get_user_or_create(username), to: UserGet, as: :or_create_by_username
  defdelegate list_products(), to: ProductList, as: :all
  defdelegate create_order(username, product_ids), to: OrderCreate, as: :by_username
end
