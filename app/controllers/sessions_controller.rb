class SessionsController < ApplicationController
  def new; end
  def admin_new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to customers_path
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new
    end
  end

  def create_admin
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admins_path
    else
      flash.now[:alert] = 'Invalid email or password for admin'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def facebook_callback
    user = User.find_or_create_by(uid: request.env['omniauth.auth'][:uid],
                                  provider: request.env['omniauth.auth'][:provider]) do |u|
      u.name = request.env['omniauth.auth'][:info][:name]
      u.email = request.env['omniauth.auth'][:info][:email]
      u.password = SecureRandom.hex(15)
    end

    if user.valid?
      session[:user_id] = user.id
      session[:access_token] = request.env['omniauth.auth'].credentials.token
      redirect_to home_index_path
    else
      redirect_to login_path
    end
  end
end
