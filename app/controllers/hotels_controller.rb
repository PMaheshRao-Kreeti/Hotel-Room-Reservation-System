class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[edit show room_count update destroy]

  include HotelsHelper

  def index
    @hotels = Hotel.all
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

  def update
    if @hotel.update(hotel_params)
      redirect_to hotels_path, notice: 'hotel has been updated successfully'
    else
      render :new
    end
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
