class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  has_many :purchases, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :address, presence: true

  def cart
    if purchases.find_by(paid_at: nil).nil?
      purchases.create
    else
      purchases.find_by(paid_at: nil)
    end
  end

  def include_in_cart?(food)
    cart.purchase_details.find_by(food_id: food.id).present?
  end
end
