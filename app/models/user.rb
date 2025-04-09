class User < ApplicationRecord
  has_many :products, foreign_key: :seller_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, seller: 1, admin: 2 }
end
