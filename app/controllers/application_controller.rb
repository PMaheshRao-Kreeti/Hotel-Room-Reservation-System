# frozen_string_literal: true

# ApplicationContoller
class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :notification_count, :unread_notifications
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  def notification_count
    current_user.notifications.where(status: false).count
  end

  def unread_notifications
    current_user.notifications.where(status: false)
  end

  private

  def render_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

end
