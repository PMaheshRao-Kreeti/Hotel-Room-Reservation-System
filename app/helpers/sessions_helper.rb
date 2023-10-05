# frozen_string_literal: true

# SessionsHelper
module SessionsHelper
  def authenticate_user(email, password)
    user = User.find_by(email:)
    user if user&.authenticate(password)
  end

  def redirect_to_user_path(role)
    case role
    when 'customer'
      redirect_to customers_path
    when 'hotel_admin'
      redirect_to admins_path
    when 'super_admin'
      redirect_to admins_path
    end
  end

  def setup_user_session(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
    return unless user.hotel_admin?

    hotel_admin = HotelAdmin.find_by(user_id: user.id)
    session[:hotel_id] = hotel_admin.hotel_id
  end

  # facebook session setup and creation
  def find_or_create_user_from_facebook(auth)
    info = auth[:info]
    User.find_or_create_by(uid: auth[:uid], provider: auth[:provider]) do |u|
      u.name = info[:name]
      u.email = info[:email]
      u.password = SecureRandom.hex(15)
    end
  end

  def setup_user_session_facebook(user, access_token)
    session[:user_id] = user.id
    session[:access_token] = access_token
  end
end
