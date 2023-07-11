class UsersController < ApplicationController
  def new
    @user = User.new
  end

  # create a new user
  def create
    @user = User.new(user_params)
    @user.role = :customer # Set role as customer by default

    if @user.save
      session[:user_id] = @user.id
      redirect_to cus_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :role)
  end
end
