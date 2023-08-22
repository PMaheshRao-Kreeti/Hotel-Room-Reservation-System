# frozen_string_literal: true

# Sessioncontroller create and destroy created session
class SessionsController < ApplicationController
  def new
    redirect_to customers_path if user_logged_in? && current_user.role == 'customer'
  end

  def admin_new
    redirect_to admins_path if user_logged_in? && current_user.role == 'admin'
  end

  def create
    user = authenticate_user(params[:email], params[:password])
    if user
      setup_user_session(user)
      redirect_to customers_path
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def create_admin
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password]) && user&.admin?
      session[:user_id] = user.id
      redirect_to admins_path
    else
      flash.now[:alert] = 'Invalid email or password'
      render :admin_new
    end
  end

  def destroy
    reset_session
    cookies.delete(:user_id)
    redirect_to root_path
  end

  def facebook_callback
    user = find_or_create_user_from_facebook(request.env['omniauth.auth'])
    if user.valid?
      setup_user_session_facebook(user, request.env['omniauth.auth'].credentials.token)
      redirect_to home_index_path
    else
      redirect_to login_path
    end
  end

  private

  def redirect_to_user_path(role)
    case role
    when 'customer'
      redirect_to customers_path
    when 'admin'
      redirect_to admins_path
    end
  end

  def authenticate_user(email, password)
    user = User.find_by(email:)
    user if user&.authenticate(password)
  end

  def setup_user_session(user)
    session[:user_id] = user.id
    cookies.signed[:user_id] = user.id
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
