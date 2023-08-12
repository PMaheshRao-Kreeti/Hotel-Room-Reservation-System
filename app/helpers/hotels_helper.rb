# frozen_string_literal: true

# HotelHelper
module HotelsHelper
  # method that give number of room in the hotel
  def available_room_count(hotel, checkin = Date.today, checkout = Date.today + 1)
    @single_bedroom_count = count_available_rooms(hotel, 'Single Bed', checkin, checkout)
    @double_bedroom_count = count_available_rooms(hotel, 'Double Bed', checkin, checkout)
    @suite_count = count_available_rooms(hotel, 'Suite', checkin, checkout)
    @dormitory_count = count_available_rooms(hotel, 'Dormitory', checkin, checkout)

    @total_number_of_available_rooms = @single_bedroom_count + @double_bedroom_count + @suite_count + @dormitory_count
    @guest_capacity = 2 * @single_bedroom_count + 4 * @double_bedroom_count + 8 * @suite_count + 16 * @dormitory_count
  end

  # method to calculate
  def count_available_rooms(hotel, room_type, checkin, checkout)
    available_rooms = hotel.rooms.where(room_type:)
    booked_rooms = hotel.bookings.where('check_in_date >= ? AND check_out_date <= ? AND hotel_id = ? AND room_type = ?',
                                        checkin, checkout, hotel.id, room_type)
    available_rooms.count - booked_rooms.count
  end

  # for admin instead od showing available rooms it shows all rooms in the hotel
  # total_number_of_rooms_in_hotel(hotel)
  def total_number_of_rooms_in_hotel(hotel)
    @single_bedroom_count = hotel.rooms.where(room_type: 'Single Bed').count
    @double_bedroom_count = hotel.rooms.where(room_type: 'Double Bed').count
    @suite_count = hotel.rooms.where(room_type: 'Suite').count
    @dormitory_count = hotel.rooms.where(room_type: 'Dormitory').count
  end
end
