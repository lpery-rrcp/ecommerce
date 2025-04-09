class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  enum status: { pending: 0, completed: 1, failed: 2 }
  enum payment_method: { credit_card: 0, paypal: 1, bank_transfer: 2 }
end
