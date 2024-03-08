class Purchase < ApplicationRecord
  extend Enumerize

  enumerize :delivery_at, in: %w[8-12 12-14 14-16 16-18 18-20 20-21]

  has_many :purchase_details
  belongs_to :user
end
