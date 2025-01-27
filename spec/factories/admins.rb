FactoryBot.define do
  factory :admin do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }

    trait :with_invitations do
      after(:create) do |admin|
        create_list(:invitation, 3, admin: admin)
      end
    end
  end
end
