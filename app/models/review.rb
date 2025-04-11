class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :comment, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  def self.ransackable_attributes(auth_object = nil)
    %w[id comment rating user_id product_id created_at updated_at]
  end
end
