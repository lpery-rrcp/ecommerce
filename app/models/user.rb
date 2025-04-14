class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  self.enum :role, { customer: 0, seller: 1, admin: 2 }, prefix: true

  belongs_to :province, optional: true

  has_many :products, foreign_key: :seller_id
  has_many :reviews
  has_many :orders, foreign_key: "user_id"
  has_many :customer_orders, class_name: "Order", foreign_key: "customer_id"

  def self.ransackable_attributes(auth_object = nil)
    [ "address", "city", "created_at", "email", "encrypted_password", "id", "id_value", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "orders", "products", "province", "reviews" ]
  end

  def full_address
    [ address, city, province&.name ].compact.join(", ")
  end
end
