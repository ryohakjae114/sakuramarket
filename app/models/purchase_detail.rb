class PurchaseDetail < ApplicationRecord
  belongs_to :purchase
  belongs_to :food

  attr_accessor :user_trying_purchase

  validates :number, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}

  def set_purchase(user)
    self.purchase =
      if Purchase.find_by(paid_at: nil, user: user).nil?
        Purchase.create(user: user)
      else
        Purchase.find_by(paid_at: nil, user: user)
      end
  end

  def total_price_with_tax
    self.food.price_with_tax * self.number
  end

  def add_number!(number)
    self.number += number
    self.save!
  end
end
