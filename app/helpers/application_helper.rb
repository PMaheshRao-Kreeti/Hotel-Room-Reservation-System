module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # return true false depending upon user or admin is logged in or not
  def user_logged_in?
    current_user
  end
end
