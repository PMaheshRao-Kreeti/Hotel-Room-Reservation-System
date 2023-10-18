# frozen_string_literal: true

# Sessioncontroller create and destroy created session
class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def new
    redirect_to_user_path(current_user.role) if user_logged_in?
  end

  def admin_new
    redirect_to_user_path(current_user.role) if user_logged_in?
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
    user = authenticate_user(params[:email], params[:password])
    if user
      setup_user_session(user)
      redirect_to_user_path(user.role)
    else
      flash.now[:alert] = 'Invalid email or password (or super admin doesnot assign you hotel)'
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
end
