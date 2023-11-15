# frozen_string_literal: true

# spec/factories/hotel_gallery_images.rb

FactoryBot.define do
  factory :hotel_gallery_image do
    association :hotel
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'sample_image.jpg'), 'image/jpeg') }
  end
end
