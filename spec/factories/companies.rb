FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    cnpj { CNPJ.generate(format: true) }
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    neighborhood { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }

    trait :invalid do
      name { "" }
      cnpj { "cnpj-invalido" }
      address { nil }
    end
  end
end
