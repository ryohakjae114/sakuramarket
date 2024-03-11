FactoryBot.define do
  factory :purchase do
    delivery_on { Date.today }
    delivery_time_zone { '8-12' }
  end
end
