class Province < ApplicationRecord
  has_many :customers

  validates :name, presence: true
  validates :gst, :pst, :hst, numericality: true
end
