FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    gender { User.genders.keys.sample }
    phone_number { Faker::PhoneNumber.phone_number }
    address { Faker::Address.full_address }
    role { ['Doctor', 'Patient'].sample }
    type { ['Doctor', 'Patient'].sample }

    trait :doctor do
      role { 'Doctor' }
      type { 'Doctor' }
    end

    trait :patient do
      role { 'Patient' }
      type { 'Patient' }
    end

    trait :with_avatar do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'fixtures', 'avatar.jpg'), 'image/jpeg') }
    end
  end
  
  factory :doctor, class: 'Doctor', parent: :user do
    type { 'Doctor' }
  end

  factory :patient, class: 'Patient', parent: :user do
    type { 'Patient' }
  end
end
