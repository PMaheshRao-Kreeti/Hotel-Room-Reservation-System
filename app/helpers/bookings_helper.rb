# frozen_string_literal: true

# BookingsHelper contain method that give available room option to admin while approval action.
module BookingsHelper
  def create_and_send_notification(book)
    hotel = Hotel.find_by(id: @booking.hotel_id)
    content = "Booking #{book.booking_status}: for #{hotel.name} from #{book.check_in_date} to #{book.check_out_date}."
    notification = Notification.new(user_id: book.user_id, message: content, status: false)
    send_notification(notification) if notification.save
  end

  def set_booking
    @booking = Booking.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to hotel_bookings_path, notice: e
  end

  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  # view helper
  def find_room(room_id)
    Room.find_by(id: room_id)
  end

  def find_available_room_types(bookings, rooms)
    @available_room_type = []

    if rooms.count > bookings.count
      add_available_room_type('Single Bed', bookings, rooms)
      add_available_room_type('Double Bed', bookings, rooms)
      add_available_room_type('Suite', bookings, rooms)
      add_available_room_type('Dormitory', bookings, rooms)
      @available_room_type.uniq!
    end

    @available_room_type
  end

  def add_available_room_type(room_type, bookings, rooms)
    room_booking_count = bookings.where(room_type:).where(booking_status: %w[approved pending]).count
    available_count = rooms.where(room_type:).count - room_booking_count
    @available_room_type << room_type if available_count.positive? && !@available_room_type.include?(room_type)
  end
end
