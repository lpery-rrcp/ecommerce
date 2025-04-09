class AddForeignKeyToProducts < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :products, :users, column: :seller_id
  end
end
