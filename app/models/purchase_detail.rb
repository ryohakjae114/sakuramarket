class PurchaseDetail < ApplicationRecord
  belongs_to :purchase
  belongs_to :food

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}

  def total_price_with_tax
    food.price_with_tax * quantity
  end
end
