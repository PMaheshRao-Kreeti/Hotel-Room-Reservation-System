module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # return true false depending upon user or admin is logged in or not
  def user_logged_in?
    current_user
  end

  # method to count room available
  def room_count(hotel)
    @single_bedroom_count = 0
    @double_bedroom_count = 0
    @suite_count = 0
    @dormitory_count = 0

    hotel.rooms.each do |room|
      case room.room_type
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
end
