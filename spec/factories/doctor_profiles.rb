FactoryBot.define do
  factory :doctor_profile do
    association :doctor, factory: :user
    specialty { Faker::Job.field }
    bio { Faker::Lorem.paragraph }
  end
end
