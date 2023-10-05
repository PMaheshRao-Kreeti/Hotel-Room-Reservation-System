# frozen_string_literal: true

# HotelController handle CRUD on Hotels Room
class RoomsController < ApplicationController
  before_action :set_room, only: %i[edit show update destroy]
  before_action :set_hotel, only: %i[new create edit update destroy]

  def new
    @room = Room.new
  end

  def create
    @room = @hotel.rooms.create(room_params)
    if @room.save
      redirect_to hotel_show_room_path(@hotel), notice: "Room at #{@hotel.name} was successfully created "
    else
      render :new
    end
  end

  def edit; end

  def update
    if @room.update(room_params)
      redirect_to hotel_show_rooms_path(@hotel), notice: "Room at #{@hotel.name} was successfully updated ."
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to hotel_room_path(@hotel), notice: "Room was successfully destroyed from #{@hotel.name} ."
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def room_params
    params.require(:room).permit(:room_type, :price, :hotel_id, :room_number)
  end
end
