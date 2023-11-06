# frozen_string_literal: true

# HotelHelper
module HotelsHelper
  def filter_hotels
    @hotels = Hotel.all
    apply_destination_filter
    apply_guests_filter
    apply_rooms_filter
  end

  def apply_destination_filter
    return unless params[:destination].present?

    @hotels = @hotels.filter_by_destination(params[:destination])
  end

  def apply_guests_filter
    return unless params[:guests].present?

    @hotels = if @checkin
                @hotels.filter_by_no_of_guests(params[:guests].to_i, @hotels, params[:checkin], params[:checkout])
              else
                @hotels.filter_by_no_of_guests(params[:guests].to_i, @hotels)
              end
  end

  def apply_rooms_filter
    return unless params[:rooms].present?

    @hotels = if @checkin
                @hotels.filter_by_no_of_rooms(params[:rooms].to_i, @hotels, params[:checkin], params[:checkout])
              else
                @hotels.filter_by_no_of_rooms(params[:rooms].to_i, @hotels)
              end
  end

  # method that give number of room in the hotel
  def available_room_count_of_hotel(hotel, checkin = Date.today, checkout = Date.tomorrow)
    @single_bedroom_count = hotel.available_rooms_count(checkin, checkout, 'Single Bed')
    @double_bedroom_count = hotel.available_rooms_count(checkin, checkout, 'Double Bed')
    @suite_count = hotel.available_rooms_count(checkin, checkout, 'Suite')
    @dormitory_count = hotel.available_rooms_count(checkin, checkout, 'Dormitory')
  end
end
