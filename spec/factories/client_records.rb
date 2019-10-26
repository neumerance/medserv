FactoryBot.define do
  factory :client_record do
    association :client, factory: :client
    systolic { 120 }
    diastolic { 80 }
    heart_rate { 72 }
    weight { 75 }
    findings { FFaker::Lorem.paragraph }
    remarks { FFaker::Lorem.sentence }

    trait :this_week do
      after(:create) do |rec|
        rec.created_at = Time.now.end_of_week
        rec.save!
      end
    end

    trait :last_week do
      after(:create) do |rec|
        rec.created_at = (Time.now.beginning_of_week - 1.day).end_of_week
        rec.save!
      end
    end
  end
end
