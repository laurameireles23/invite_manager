admin = Admin.first_or_create!(
  email: 'teste@exemplo.com',
  password: '123456',
  name: 'Admin Teste'
)

company = Company.create!(
  name: 'Vik ings',
  cnpj: CNPJ.generate(format: true),
  street: 'Rua Teste',
  number: '123',
  neighborhood: 'Centro',
  city: 'São Paulo',
  state: 'SP'
)

5.times do |i|
  Invitation.create!(
    name: "Convite Janeiro #{i+1}",
    email: Faker::Internet.email,
    company: company,
    admin: admin,
    created_at: Time.zone.parse("2025-01-15") - 10.days,
    disable_at: nil
  )
end

5.times do |i|
  invitation = Invitation.create!(
    name: "Convite Desativado #{i+1}",
    email: Faker::Internet.email,
    company: company,
    admin: admin,
    created_at: Time.zone.now + 1.days,
    status: "cancelled"
  )

  invitation.update(disable_at: Time.zone.parse("2025-01-17"))
end
