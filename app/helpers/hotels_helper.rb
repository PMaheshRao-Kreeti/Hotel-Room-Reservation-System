module HotelsHelper
  # method that give number of room in the hotel
  def available_room_count(hotel, checkin = Date.today, checkout = Date.today+1)
    @single_bedroom_count = hotel.rooms.where(room_type: 'Single Bed').count - hotel.bookings.where('check_in_date >= ? AND check_out_date <= ? AND hotel_id = ? AND room_type = ?',checkin, checkout, hotel.id, 'Single Bed').count
    @double_bedroom_count = hotel.rooms.where(room_type: 'Double Bed').count - hotel.bookings.where('check_in_date >= ? AND check_out_date <= ? AND hotel_id = ? AND room_type = ?',checkin, checkout, hotel.id, 'Double Bed').count
    @suite_count = hotel.rooms.where(room_type: 'Suite').count - hotel.bookings.where('check_in_date >= ? AND check_out_date <= ? AND hotel_id = ? AND room_type = ?',checkin, checkout, hotel.id, 'Suite').count
    @dormitory_count = hotel.rooms.where(room_type: 'Dormitory').count - hotel.bookings.where('check_in_date >= ? AND check_out_date <= ? AND hotel_id = ? AND room_type = ?',checkin, checkout, hotel.id, 'Dormitory').count
  
    @total_number_of_available_rooms = @single_bedroom_count + @double_bedroom_count + @suite_count + @dormitory_count
    @total_guest_capacity = 2 * @single_bedroom_count + 4 * @double_bedroom_count + 8 * @suite_count + 16 * @dormitory_count
  end
end
