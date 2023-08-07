# frozen_string_literal: true

# BookingsHelper contain method that give available room option to admin while approval action.
module BookingsHelper
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
    available_count = rooms.where(room_type:).count - bookings.where(room_type:).count
    @available_room_type << room_type if available_count.positive? && !@available_room_type.include?(room_type)
  end
end
