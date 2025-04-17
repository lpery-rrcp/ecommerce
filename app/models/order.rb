class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items, dependent: :destroy

  enum :status, { pending: 0, shipped: 1, delivered: 2, cancelled: 3, paid: 4, unpaid: 5 }

  validates :status, presence: true
  validates :total_price, presence: true, numercality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "status", "total_price", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "order_items", "payment", "user" ]
  end
end
