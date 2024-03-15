class Purchase < ApplicationRecord
  extend Enumerize

  FIRST_DAY_OF_DELIVERY_AVAILABLE = 3
  LAST_DAY_OF_DELIVERY_AVAILABLE = 14
  TIME_ZONES_DELIVERY_AVAILABLE = %w[8-12 12-14 14-16 16-18 18-20 20-21].freeze

  enumerize :delivery_time_zone, in: TIME_ZONES_DELIVERY_AVAILABLE

  belongs_to :user
  has_many :purchase_details, dependent: :destroy
  accepts_nested_attributes_for :purchase_details, allow_destroy: true

  validate :date_delivery_not_available

  before_save -> { self.paid_at = Time.current }

  def self.dates_of_delivery_available
    (FIRST_DAY_OF_DELIVERY_AVAILABLE..LAST_DAY_OF_DELIVERY_AVAILABLE).map { |i| i.business_days.after.to_date }
  end

  def date_delivery_not_available
    Purchase.dates_of_delivery_available.include?(delivery_on)
  end

  def total_price
    total_purchase_details_price + postage_price + charge_price
  end

  def total_purchase_details_price
    purchase_details.inject(0) { |sum, purchase_detail| sum + purchase_detail.total_price_with_tax }
  end

  def postage_price
    (purchase_details.inject(0) { |sum, purchase_detail| sum + purchase_detail.quantity } / 5.0).ceil * 600
  end

  def charge_price
    case total_purchase_details_price
    when 0..10_000
      (300 * (1 + TAX_RATE)).floor
    when 10_000..30_000
      (400 * (1 + TAX_RATE)).floor
    when 30_000..100_000
      (600 * (1 + TAX_RATE)).floor
    else
      (1000 * (1 + TAX_RATE)).floor
    end
  end
end
