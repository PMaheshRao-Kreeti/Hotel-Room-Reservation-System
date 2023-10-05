# frozen_string_literal: true

# HotelHelper
module HotelsHelper
  def initialize_filter_variables
    @destination = params[:destination]
    @checkin_date = params[:checkin]
    @checkout_date = params[:checkout]
    @no_of_guests = params[:guests].to_i
    @no_of_rooms = params[:rooms].to_i
  end

  def filter_hotels
    @hotels = @destination.present? && @destination != '' ? Hotel.search(@destination).records : Hotel.all
    @filter_hotel_list = if @checkin_date.present? && @checkout_date.present?
                           loop_available_room_count(@hotels, @no_of_guests, @no_of_rooms, @checkin_date,
                                                     @checkout_date)
                         else
                           loop_available_room_count(@hotels, @no_of_guests, @no_of_rooms)
                         end
    @hotels.reject! { |hotel| @filter_hotel_list.include?(hotel) } if @filter_hotel_list.present?
  end

  # method that give number of room in the hotel
  def available_room_count(hotel, _no_of_guest, _no_of_room, checkin = Date.today, checkout = Date.today + 1)
    @single_bedroom_count = count_available_rooms(hotel, 'Single Bed', checkin, checkout)
    @double_bedroom_count = count_available_rooms(hotel, 'Double Bed', checkin, checkout)
    @suite_count = count_available_rooms(hotel, 'Suite', checkin, checkout)
    @dormitory_count = count_available_rooms(hotel, 'Dormitory', checkin, checkout)

    @total_number_of_available_rooms = @single_bedroom_count + @double_bedroom_count + @suite_count + @dormitory_count
    @guest_capacity = 2 * @single_bedroom_count + 4 * @double_bedroom_count + 8 * @suite_count + 16 * @dormitory_count
  end

  # method to calculate
  def count_available_rooms(hotel, room_type, checkin, checkout)
    total_rooms = hotel.rooms.where(room_type:)
    booked_rooms = hotel.bookings.where('((?<= check_in_date AND ? > check_in_date) OR
                                          (?<= check_out_date)) AND hotel_id = ? AND room_type = ?',
                                        checkin, checkout, checkin, hotel.id, room_type)
    total_rooms.count - booked_rooms.where(booking_status: 'pending').count
  end

  def loop_available_room_count(hotels, no_of_guest, no_of_room, checkin = Date.today,
                                checkout = Date.today + 1)
    filtered_hotels = []
    no_of_guest = 0 unless no_of_guest.present?
    no_of_room = 0 unless no_of_room.present?
    hotels.each do |hotel|
      available_room_count(hotel, no_of_guest, no_of_room, checkin, checkout)
      filtered_hotels << hotel if @total_number_of_available_rooms >= no_of_room || @guest_capacity >= no_of_guest
    end
    filtered_hotels.uniq!
  end
end
