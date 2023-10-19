# frozen_string_literal: true

# HotelHelper
module HotelsHelper
  def filter_hotels
    @hotels = Hotel.all
    @hotels = @hotels.filter_by_destination(params[:destination]) if params[:destination].present?
    @hotels = @hotels.filter_by_no_of_guests(params[:guests].to_i) if params[:guests].present?
    @hotels = @hotels.filter_by_no_of_rooms(params[:rooms].to_i) if params[:rooms].present?
  end

  # method that give number of room in the hotel
  def available_room_count_of_hotel(hotel, checkin = Date.today, checkout = Date.today + 1)
    @single_bedroom_count = count_available_rooms(hotel, 'Single Bed', checkin, checkout)
    @double_bedroom_count = count_available_rooms(hotel, 'Double Bed', checkin, checkout)
    @suite_count = count_available_rooms(hotel, 'Suite', checkin, checkout)
    @dormitory_count = count_available_rooms(hotel, 'Dormitory', checkin, checkout)
  end

  # method to calculate
  def count_available_rooms(hotel, room_type, checkin, checkout)
    total_rooms = hotel.rooms.where(room_type:).count
    booked_rooms = hotel.bookings.where('((?<= check_in_date AND ? > check_in_date) OR
                                          (?<= check_out_date)) AND hotel_id = ? AND room_type = ?',
                                        checkin, checkout, checkin, hotel.id, room_type)
    total_rooms - booked_rooms.where(booking_status: %w[pending approved]).count
  end
end
