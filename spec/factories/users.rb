FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { 'ABC12abc' }
    password_confirmation { 'ABC12abc' }
  end
end
