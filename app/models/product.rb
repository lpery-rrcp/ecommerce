class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller, class_name: "User"

  has_many :reviews
  has_many :order_items

  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[name description category_id id created_at updated_at price stock_quantity seller_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category seller reviews order_items]
  end
end
