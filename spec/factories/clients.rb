FactoryBot.define do
  factory :client do
    name { FFaker::Name.name }
    birthdate { Date.today - [20, 22, 32, 56, 70].sample.years }
    contact_number { FFaker::PhoneNumber.short_phone_number }
    occupation { FFaker::Job.title }
    address { "#{FFaker::Address.secondary_address} #{FFaker::Address.street_address}" }
  end
end
