class User < ApplicationRecord
  belongs_to :province, optional: true
  has_many :products, foreign_key: :seller_id
  has_many :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, seller: 1, admin: 2 }
end
