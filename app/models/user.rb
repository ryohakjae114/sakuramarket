class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  has_many :purchases, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :address, presence: true
end
