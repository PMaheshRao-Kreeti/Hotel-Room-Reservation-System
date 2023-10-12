# frozen_string_literal: true

# User controller create customer account
class UsersController < ApplicationController
  def new
    if user_logged_in? && current_user.role == 'customer'
      redirect_to customers_path
    elsif user_logged_in? && current_user.role == 'admin'
      redirect_to admins_path
    else
      @user = User.new
    end
  end

  # create a new user
  def create
    @user = User.new(user_params)
    @user.role = params[:role].to_i
    @user.save
    if @user.persisted?
      session[:user_id] = @user.id
      redirect_to customers_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
  end

end
