class Promotion < ApplicationRecord
  belongs_to :product
  belongs_to :promotion

  validates :product_id, presence: true
  validates :promotion_id, presence: true
end
