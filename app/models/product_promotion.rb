class ProductPromotion < ApplicationRecord
  belongs_to :product
  belongs_to :promotion

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "product_id", "promotion_id", "updated_at" ]
  end
end
