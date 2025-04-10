class Review < ApplicationRecord
  validates :conetent, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }

  belongs_to :user
  belongs_to :product
end
