class Food < ApplicationRecord
  has_many :purchase_details

  validates :name, presence: true
  validates :price_without_tax, presence: true
end
