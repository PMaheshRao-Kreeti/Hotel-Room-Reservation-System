# frozen_string_literal: true

# spec/factories/rooms.rb
FactoryBot.define do
  factory :room do
    association :hotel # This creates a valid hotel association for the room
    room_type { 'Single Bed' }
    room_number { '101' }
    price { 499 }
    capacity { 2 }
  end
end
