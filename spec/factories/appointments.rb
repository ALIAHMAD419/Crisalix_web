FactoryBot.define do
  factory :appointment do
    association :doctor, factory: :user
    association :patient, factory: :user
    appointment_date { Faker::Time.forward(days: 23, period: :morning) }
    status { ['scheduled', 'completed', 'canceled'].sample }
    image1 { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'fixtures', 'test_image.jpg'), 'image/jpeg') }
    image2 { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'fixtures', 'test_image.jpg'), 'image/jpeg') }
    image3 { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'fixtures', 'test_image.jpg'), 'image/jpeg') }
  end
end
