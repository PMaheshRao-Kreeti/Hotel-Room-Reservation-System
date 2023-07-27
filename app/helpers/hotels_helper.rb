module HotelsHelper
  # method that give number of room in the hotel
  def room_count(hotel)
    @single_bedroom_count = hotel.rooms.where(room_type: 'Single Bed').count
    @double_bedroom_count = hotel.rooms.where(room_type: 'Double Bed').count
    @suite_count = hotel.rooms.where(room_type: 'Suite').count
    @dormitory_count = hotel.rooms.where(room_type: 'Dormitory').count
  end
end
