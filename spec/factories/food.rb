FactoryBot.define do
  factory :food do
    name { 'はっつぁん' }
    price_without_tax { 500 }
    displayed { true }
  end
end
