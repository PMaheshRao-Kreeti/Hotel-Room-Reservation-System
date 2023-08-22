# frozen_string_literal: true

# HotelController handle CRUD on Hotel
class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[edit show update destroy]
  before_action :initialize_filter_variables, only: :filter

  include HotelsHelper

  def index
    @hotels = Hotel.order(created_at: :asc)
  end

  def new
    @hotel = Hotel.new
  end

  def create
    hotel = Hotel.new(hotel_params)
    if hotel.save
      redirect_to hotels_path, notice: "Hotel [ #{hotel.name} ] created successfully."
    else
      render :new
    end
  end

  def show; end

  def show_rooms
    @hotel = Hotel.find(params[:hotel_id])
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to hotels_path, notice: "Hotel [ #{@hotel.name} ] has been updated successfully"
    else
      render :new
    end
  end

  def search
    query = params[:search_hotels].presence && params[:search_hotels][:query]
    @checkin_date = params[:checkin]
    @checkout_date = params[:checkout]
    return unless query

    @hotels = Hotel.search_by_keyword(query)
  end

  def filter
    filter_hotels
  end

  def destroy
    hotel_name = @hotel.name
    @hotel.destroy
    redirect_to hotels_path, notice: "Hotel [ #{hotel_name} ] has been deleted successfully"
  end

  private

  def initialize_filter_variables
    @loop_counter = 0
    @destination = params[:destination]
    @checkin_date = params[:checkin]
    @checkout_date = params[:checkout]
    @no_of_guests = params[:guests].to_i
    @no_of_rooms = params[:rooms].to_i
  end

  def filter_hotels
    @hotels = @destination.present? ? Hotel.search(@destination).records : Hotel.all.order(created_at: :asc)
  end

  def hotel_params
    params.require(:hotel).permit(:name, :address, :city, :state, :country, :pincode, :description,
                                  :hotel_image, :latitude, :longitude)
  end

  def set_hotel
    @hotel = Hotel.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to hotels_path, notice: e
  end
end
