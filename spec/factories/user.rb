FactoryBot.define do
  factory :user do
    email {'test@example.com'}
    last_name {'はっつ'}
    first_name {'ぁん'}
    address {'川崎市××区××町3-3-3'}
    password {'12341234'}
    password_confirmation {'12341234'}
  end
end
