module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # return true false depending upon user or admin is logged in or not
  def user_logged_in?
    current_user
  end

  def find_user(user_id)
    @user = User.find_by(id: user_id)
  end

  def find_hotel(hotel_id)
    @hotel = Hotel.find_by(id: hotel_id)
  end

  def send_notification(notification)
    ActionCable.server.broadcast(
      "NotificationChannel_#{notification.user_id}", {
        recipient_id: notification.user_id,
        message: notification.message
      }
    )
  end
end
