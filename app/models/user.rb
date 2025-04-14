class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  self.enum :role, { customer: 0, seller: 1, admin: 2 }, prefix: true

  belongs_to :province

  has_many :products, foreign_key: :seller_id
  has_many :reviews
  has_many :orders

  def self.ransackable_attributes(auth_object = nil)
    [ "address", "city", "created_at", "email", "encrypted_password", "id", "id_value", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "orders", "products", "province", "reviews" ]
  end
end
