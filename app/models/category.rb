class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "id_value", "name", "updated_at" ]
  end
end
