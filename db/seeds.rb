# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ffaker'

50.times do
  client = Client.create(
    name: FFaker::Name.name,
    birthdate: (Date.today - [20, 22, 32, 56, 70].sample.years).strftime('%b %e %a'),
    contact_number: FFaker::PhoneNumber.short_phone_number,
    occupation: FFaker::Job.title,
    address: "#{FFaker::Address.secondary_address} #{FFaker::Address.street_address}"
  )

  25.times do
    ClientRecord.create(
      client: client,
      systolic: [110, 90, 150, 220, 87].sample,
      diastolic: [90, 78, 60, 100, 120].sample,
      heart_rate: [68, 76, 92, 103, 110].sample,
      weight: [45, 52, 68, 92, 78, 120].sample,
      remarks: FFaker::Lorem.sentence,
      findings: FFaker::Lorem.paragraph
    )
  end
end
