# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    no_of_guest { 2 }
    guest_name { 'John Doe' }
    check_in_date { Date.today }
    check_out_date { Date.today + 2.days }
    booking_status { 'approved' }
    room_type { 'Single Bed' }
    user { association(:user, role: 1) }
    hotel
  end
end
