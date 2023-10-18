# frozen_string_literal: true

# HotelController handle CRUD on Hotel
class HotelsController < ApplicationController
  before_action :require_customer, only: %i[index search filter]
  before_action :require_super_admin, only: %i[new create]
  before_action :require_hotel_admin, only: %i[show show_rooms update destroy]
  before_action :set_hotel, only: %i[edit show update destroy]
  before_action :initialize_filter_variables, only: :filter

  include HotelsHelper

  def index
    @hotels = Hotel.all
  end

  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      redirect_to admin_management_path, notice: "Hotel [ #{@hotel.name} ] created successfully."
    else
      render :new
    end
  end

  def show
    @hotel_gallery_images = @hotel.hotel_gallery_images
  end

  def show_rooms
    @hotel = Hotel.includes(:rooms).find(params[:hotel_id])
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to hotel_path(session[:hotel_id]), notice: "Hotel [ #{@hotel.name} ] has been updated successfully"
    else
      render :new
    end
  end

  def search
    query = params[:search_hotels].presence && params[:search_hotels][:query]
    return unless query

    @hotels = Hotel.search_by_keyword(query)
  end

  def filter
    filter_hotels
  end

  def destroy
    hotel_name = @hotel.name
    @hotel.hotel_image.purge
    @hotel.destroy
    redirect_to hotels_path, notice: "Hotel [ #{hotel_name} ] has been deleted successfully"
  end

  private

  def hotel_params
    if current_user.super_admin?
      params.require(:hotel).permit(:name, :address, :city, :state, :country, :pincode, :latitude, :longitude)
    elsif current_user.hotel_admin?
      params.require(:hotel).permit(:name, :address, :city, :state, :country, :pincode, :description,
                                    :latitude, :longitude)
    end
  end

  def set_hotel
    @hotel = Hotel.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to hotels_path, notice: e
  end
end
