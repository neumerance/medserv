FactoryBot.define do
  factory :client_record do
    association :client, factory: :client
    systolic { 120 }
    diastolic { 80 }
    heart_rate { 72 }
    weight { 75 }
    findings { FFaker::Lorem.paragraph }
    remarks { FFaker::Lorem.sentence }
  end
end
