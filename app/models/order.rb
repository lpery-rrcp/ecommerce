class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_one :payment

  enum status: { pending: 0, shipped: 1, delivered: 2, cancelled: 3 }
end
