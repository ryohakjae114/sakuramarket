class PurchaseDetail < ApplicationRecord
  belongs_to :purchase
  belongs_to :food

  validates :number, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}

  def total_price_with_tax
    self.food.price_with_tax * self.number
  end

  def add_number!(number)
    self.number += number
    self.save!
  end
end
