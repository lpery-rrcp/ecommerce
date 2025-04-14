class AddCustomerToOrders < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :customer, null: true, foreign_key: { to_table: :users }
  end
end
