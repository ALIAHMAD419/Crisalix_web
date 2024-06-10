FactoryBot.define do
  factory :patient_profile do
    association :patient, factory: :user
    medical_history { Faker::Lorem.paragraph }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 90) }
    blood_type { Faker::Blood.type }
    allergies { Faker::Lorem.sentence }
    emergency_contact_name { Faker::Name.name }
    emergency_contact_phone { Faker::PhoneNumber.phone_number }
    insurance_provider { Faker::Company.name }
  end
end
