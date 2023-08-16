# frozen_string_literal: true

# spec/factories/hotels.rb
FactoryBot.define do
  factory :hotel do
    name { 'Sample Hotel' }
    address { '123 Main Street' }
    city { 'Sample City' }
    state { 'Sample State' }
    country { 'Sample Country' }
    pincode { '12345' }
    description { 'A sample hotel description.' }
    hotel_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'sample_image.jpg'), 'image/jpeg') }
    latitude { 42.123456 }
    longitude { -71.987654 }
  end
end
