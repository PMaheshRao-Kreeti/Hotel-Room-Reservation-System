class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[edit show hotel_rooms update destroy]

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
      redirect_to hotels_path, notice: 'hotel created successfully.'
    else
      render :new
    end
  end

  def show; end

  def show_rooms
    @hotel = Hotel.find(params[:id])
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to hotels_path, notice: 'hotel has been updated successfully'
    else
      render :new
    end
  end

  def search
    query = params[:search_hotels].presence && params[:search_hotels][:query]
    @checkin_date = params[:checkin]
    @checkout_date = params[:checkout]
    if query
      @hotels = Hotel.search_by_keyword(query)
    end
  end

  def filter
    @loop_counter = 0
    destination = params[:destination]
    @checkin_date = params[:checkin]
    @checkout_date = params[:checkout]
    @no_of_guests = params[:guests].to_i
    @no_of_rooms = params[:rooms].to_i
    
    @hotels = (destination.present?) ? Hotel.search(destination).records : Hotel.all.order(created_at: :asc)

  end

  def destroy
    @hotel.destroy
    redirect_to hotels_path, notice: 'hotel has been deleted successfully'
  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :address, :city, :state, :country, :pincode, :description, :hotel_image, :latitude,
                                  :longitude)
  end

  def set_hotel
    @hotel = Hotel.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to hotels_path, notice: e
  end
end
