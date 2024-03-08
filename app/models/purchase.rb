class Purchase < ApplicationRecord
  extend Enumerize

  TIME_ZONE_DELIVERY_AVAILABLE = %w[8-12 12-14 14-16 16-18 18-20 20-21]
  enumerize :delivery_time_zone, in: TIME_ZONE_DELIVERY_AVAILABLE

  has_many :purchase_details
  belongs_to :user

  def total_purchase_details_price
    self.purchase_details.inject(0) { |sum, purchase_detail| sum + purchase_detail.total_price_with_tax }
  end
end
