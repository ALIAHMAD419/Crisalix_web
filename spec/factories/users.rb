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
end


# FactoryBot.define do
#   factory :user do
#     email { Faker::Internet.email }
#     encrypted_password { Devise.friendly_token }
#     name { Faker::Name.name }
#     type { ['Doctor', 'Patient'].sample }
#     gender { User.genders.keys.sample }
#     phone_number { Faker::PhoneNumber.phone_number }
#     address { Faker::Address.full_address }
#     # after(:build) do |user|
#       # user.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'fixtures', 'avatar.jpg')), filename: 'avatar.jpg', content_type: 'image/jpg')
#     # end
#   end
# end
