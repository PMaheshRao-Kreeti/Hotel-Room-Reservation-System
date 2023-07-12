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
    params.require(:room).permit(:room_type, :price, :capacity, :availability, :hotel_id, :interior_image,
                                 :exterior_image, :bedroom_image, :outside_view_image, :swimming_pool_image)
  end
end
