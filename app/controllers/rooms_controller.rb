class RoomsController < ApplicationController
  before_action :set_room, only: %i[edit show update destroy]

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    room_capacity_based_on_room_type(@room)
    if @room.save
      redirect_to rooms_path, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @room.update(room_params)
      redirect_to rooms_path, notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_path, notice: 'Room was successfully destroyed.'
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:room_type, :price, :capacity, :hotel_id, :interior_image,
                                 :exterior_image, :bedroom_image, :room_number)
  end

  def room_capacity_based_on_room_type(room)
    case room.room_type
    when 'Single Bed'
      room.capacity = 2
    when 'Double Bed'
      room.capacity = 4
    when 'Suite'
      room.capacity = 8
    when 'Dormitory'
      room.capacity = 16
    end
  end
end
