class AddProductIdToReviews < ActiveRecord::Migration[8.0]
  def change
    add_column :reviews, :product_id, :integer
  end
end
