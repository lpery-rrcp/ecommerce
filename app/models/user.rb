class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum role: { customer: 0, seller: 1, admin: 2 }

  has_many :products, foreign_key: :seller_id
  has_many :reviews
  has_many :orders
end
