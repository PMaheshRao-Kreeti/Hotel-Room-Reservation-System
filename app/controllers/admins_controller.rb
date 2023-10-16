# frozen_string_literal: true

# Admins Controller
class AdminsController < ApplicationController
  before_action :require_super_admin
  before_action :require_hotel_admin, only: %i[admin_index]
  def admin_index; end

  def hotel_admin_management
    @hotels = Hotel.all
  end

  def new
    @hotel = Hotel.find(params[:id])
    assigned_hotel_admin_id = HotelAdmin.pluck(:user_id)
    @not_assigned_hotel_admin_list = User.hotel_admin.excluding_assigned_admin(assigned_hotel_admin_id)
  end

  def create
    if HotelAdmin.create(
      hotel_id: params[:hotel_id],
      user_id: params[:admin_id]
    )
      redirect_to admin_management_path, notice: 'Admin assignned successfully.'
    else
      render :new
    end
  end

  def destroy
    hotel_admin = HotelAdmin.find_by(hotel_id: params[:id])
    hotel_admin.destroy
    redirect_to admin_management_path, alert: 'Admin removed successfully.'
  end
end
