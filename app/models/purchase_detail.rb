class PurchaseDetail < ApplicationRecord
  belongs_to :purchase
  belongs_to :food

  attr_accessor :user_trying_purchase

  def set_purchase(user)
    self.purchase =
      if Purchase.find_by(paid_at: nil, user: user).nil?
        Purchase.create(user: user)
      else
        Purchase.find_by(paid_at: nil, user: user)
      end
  end
end
