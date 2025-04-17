class Product < ApplicationRecord
  belongs_to :category
  belongs_to :seller, class_name: "User"

  has_many :reviews
  has_many :order_items
  has_many :product_promotions, dependent: :destroy
  has_many :promotions, through: :product_promotions

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than__or_equal_to: 0 }
  validates :stock_quantity, presence: true, numericality: { only_integer: true, greater_than__or_equal_to: 0 }
  validates :discount, presence: true, numericality: { greater_than: 0 }
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  def self.ransackable_attributes(auth_object = nil)
    %w[
      name description category_id id created_at updated_at price stock_quantity
      seller_id on_sale
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category seller reviews order_items]
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after the start date") if end_date <= start_date
  end
end
