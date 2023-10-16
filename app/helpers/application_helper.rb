# frozen_string_literal: true

# Applicationhelper
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

  def require_hotel_admin
    return unless current_user.role != 'hotel_admin'

    if current_user.role == 'customer'
      redirect_to customers_path, alert: 'You are not authorized to access this url'
    else
      redirect_to admins_path, alert: 'You are not authorized to access this url'
    end
  end

  def require_super_admin
    return unless current_user.role != 'super_admin'

    if current_user.role == 'customer'
      redirect_to customers_path, alert: 'You are not authorized to access this url'
    else
      redirect_to admins_path, alert: 'You are not authorized to access this url'
    end
  end

  def notification_count
    current_user.notifications.where(status: false).count
  end

  def unread_notifications
    current_user.notifications.where(status: false)
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
