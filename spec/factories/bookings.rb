# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    no_of_guest { 2 }
    guest_name { 'John Doe' }
    check_in_date { Date.today }
    check_out_date { Date.today + 2.days }
    booking_status { 'approved' }
    room_type { 'Single Bed' }
    hotel_name { 'Hotel' }
    user { association(:user, role: 2) }
    hotel
  end
end
