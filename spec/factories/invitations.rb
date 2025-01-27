FactoryBot.define do
  factory :invitation do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    status { 'pending' }
    disable_at { nil }
    association :company
    association :admin

    trait :cancelled do
      status { 'cancelled' }
      disable_at { Time.current }
    end
  end
end
