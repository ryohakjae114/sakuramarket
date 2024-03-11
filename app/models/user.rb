class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :purchases, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :address, presence: true
  validates :last_name, presence: true

  def cart
    if self.purchases.find_by(paid_at: nil).nil?
      self.purchases.create
    else
      self.purchases.find_by(paid_at: nil)
    end
  end

  def include_in_cart?(food)
    self.cart.purchase_details.find_by(food_id: food.id).present?
  end
end
