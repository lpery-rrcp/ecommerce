class AddStripePaymentIdToPayments < ActiveRecord::Migration[8.0]
  def change
    add_column :payments, :stripe_payment_id, :string
  end
end
