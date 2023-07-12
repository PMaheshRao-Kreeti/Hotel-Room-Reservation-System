module HotelsHelper
  def room_count(hotel)
    @single_bedroom_count = 0
    @double_bedroom_count = 0
    @suite_count = 0
    @dormitory_count = 0

    count_rooms(hotel)
  end

  def count_rooms(hotel)
    hotel.rooms.each do |room|
      increment_room_count(room.room_type)
    end
  end

  def increment_room_count(room_type)
    case room_type
    when 'Single Bed'
      @single_bedroom_count += 1
    when 'Double bed'
      @double_bedroom_count += 1
    when 'Suite'
      @suite_count += 1
    when 'Dormitory'
      @dormitory_count += 1
    end
  end
end
