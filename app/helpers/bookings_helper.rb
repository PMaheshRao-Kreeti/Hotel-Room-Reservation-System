# frozen_string_literal: true

# BookingsHelper contain method that give available room option to admin while approval action.
module BookingsHelper
  def find_room(room_id)
    Room.find_by(id: room_id)
  end

  def find_available_room_types(bookings, rooms)
    bookings_count = bookings.count
    rooms_count = rooms.count
    @available_room_type = []
    
    if (rooms_count - bookings_count).positive?
      if bookings.present?  
        if ((rooms.where(room_type: 'Single Bed').count - bookings.where(room_type: 'Single Bed').count).positive? && !(@available_room_type.include?('Single Bed')))
          @available_room_type << 'Single Bed'
        end
        if (rooms.where(room_type: 'Double Bed').count - bookings.where(room_type: 'Double Bed').count).positive?
          @available_room_type << 'Double Bed'
        end
        if (rooms.where(room_type: 'Suite').count - bookings.where(room_type: 'Suite').count).positive?
          @available_room_type << 'Suite'
        end
        if (rooms.where(room_type: 'Dormitory').count - bookings.where(room_type: 'Dormitory').count).positive?
          @available_room_type << 'Dormitory'
        end
      else
        rooms.each do |room|
          @available_room_type << room.room_type
        end
      end
      @available_room_type.uniq!
    end
    return @available_room_type
  end
end
