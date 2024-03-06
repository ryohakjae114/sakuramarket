class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :purchases

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :address, presence: true
  validates :last_name, presence: true
end
