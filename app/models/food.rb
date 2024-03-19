class Food < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [300, 300]
  end
  has_many :purchase_details, dependent: :nullify

  acts_as_list

  validates :name, presence: true
  validates :price_without_tax, presence: true

  scope :displayed, -> { where(displayed: true) }

  def price_with_tax
    (price_without_tax * (1 + TAX_RATE)).floor
  end

  def variant_saved_or_default_image
    if image.representable?
      image.variant(:display)
    else
      'no_image.png'
    end
  end
end
