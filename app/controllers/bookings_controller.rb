# frozen_string_literal: true

# Controller for managing bookings.
class BookingsController < ApplicationController
  before_action :set_booking, only: %i[edit approval update cancelled]
  before_action :set_hotel, only: %i[new create edit approval update]

  include ApplicationHelper
  include BookingsHelper

  def index
    @all_bookings = Booking.all_for_hotel(session[:hotel_id])
    @todays_bookings = Booking.todays_for_hotel(session[:hotel_id])
  end

  def booking_history
    @bookings = Booking.current_user_bookings(current_user.id)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = session[:user_id]
    @booking.hotel_id = @hotel.id
    @booking.hotel_name = @hotel.name
    @booking.booking_status = 'pending'

    return unless @booking.save!

    BookingMailer.with(booking: @booking).booking_done.deliver_now
    redirect_to bookings_history_path, notice: 'Booking Done successfully.'
  end

  def approval
    booked_room_ids = Booking.filter_by_hotel_and_roomtype(@booking.hotel_id, @booking.room_type)
                             .overlapping_dates(@booking.check_out_date, @booking.check_in_date)
                             .pluck(:room_id)

    @available_rooms = Room.filter_by_hotel_and_roomtype(@booking.hotel_id, @booking.room_type)
                           .excluding_room_ids(booked_room_ids)
  end

  def details
    @hotel = Hotel.find(params[:hotel_id])
    @single_bedroom = @hotel.rooms.room_prices('Single Bed')
    @double_bedroom = @hotel.rooms.room_prices('Double Bed')
    @suite = @hotel.rooms.room_prices('Suite')
    @dormitory = @hotel.rooms.room_prices('Dormitory')
  end

  def show
    @booking = Booking.find(params[:id])
    @hotel = Hotel.find(params[:hotel_id])
    @user = User.find(@booking.user_id)
  end

  def update
    if @booking.update(admin_booking_update_params)
      create_and_send_notification(@booking)
      @booking.room_id = '' if @booking.booking_status == 'rejected' || @booking.booking_status == 'pending'
      @booking.save

      BookingMailer.with(booking: @booking).booking_admin_action.deliver_now
      redirect_to bookings_path, notice: 'Booking Status was successfully updated.'
    else
      render :approval
    end
  end

  # handle ajax request for booking checking
  def availibility_checking
    hotel = Hotel.find_by(id: params[:hotel_id])
    bookings = Booking.for_date_range_and_hotel(params[:check_in_date], params[:check_out_date], hotel.id)
    rooms = hotel.rooms
    find_available_room_types(bookings, rooms)

    respond_to do |format|
      format.json { render json: @available_room_type }
    end
  end

  # booking in app notification
  def markread
    user = params[:selected_btn]
    notifications = Notification.where(user_id: user)
    notifications.update(status: true)
  end

  def cancelled
    @booking.room_id = '' if @booking.booking_status == 'approved'
    @booking.booking_status = 'cancelled'
    @booking.save
    redirect_to bookings_history_path, notice: 'Your booking is successfully cancelled.'
  end

  private

  def booking_params
    params.require(:booking).permit(:no_of_guest, :guest_name, :check_in_date, :check_out_date, :booking_status,
                                    :room_type, :user_id, :hotel_id)
  end

  def admin_booking_update_params
    params.require(:booking).permit(:booking_status, :room_id)
  end
end
