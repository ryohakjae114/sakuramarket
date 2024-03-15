class Food < ApplicationRecord
  has_many :purchase_details

  acts_as_list
  mount_uploader :image, ImageUploader

  scope :displayed, -> { where(displayed: true) }

  def price_with_tax
    (price_without_tax * (1 + TAX_RATE)).floor
  end

  validates :name, presence: true
  validates :price_without_tax, presence: true
end
