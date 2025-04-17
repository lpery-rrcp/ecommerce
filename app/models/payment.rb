class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  enum :status, { pending: 0, completed: 1, failed: 2 }
  enum :payment_method, { credit_card: 0, paypal: 1, bank_transfer: 2 }

  validates status:, presence: true
  validates payment_method, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "order_id", "payment_method", "status", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "order" ]
  end
end
