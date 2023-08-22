# frozen_string_literal: true

# Controller for managing bookings.
class BookingsController < ApplicationController
  before_action :set_booking, only: %i[edit approval update destroy cancelled]
  before_action :set_hotel, only: %i[new create edit approval update]

  include ApplicationHelper
  include HotelsHelper
  include BookingsHelper

  def index
    @all_bookings = Booking.where.not(booking_status: 'cancelled').order(created_at: :desc)
    @todays_bookings = @all_bookings.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  end

  def booking_history
    @bookings = Booking.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = session[:user_id]
    @booking.hotel_id = @hotel.id
    @booking.booking_status = 'pending'

    if @booking.save
      BookingMailer.with(booking: @booking).booking_done.deliver_now
      redirect_to bookings_history_path, notice: 'Booking Done successfully.'
    else
      render :new
    end
  end

  def approval
    find_hotel(@booking.hotel_id)
  end

  def update
    if @booking.update(admin_booking_update_params)

      create_and_send_notification(@booking)

      @booking.room_id = '' if @booking.booking_status == 'rejected' || @booking.booking_status == 'pending'
      @booking.save

      BookingMailer.with(booking: @booking).booking_admin_action.deliver_now
      redirect_to bookings_path, notice: 'Booking was successfully updated.'
    else
      render :approval
    end
  end

  # handle ajax request for booking checking
  def availibility_checking
    check_in_date = params[:check_in_date]
    check_out_date = params[:check_out_date]
    hotel = Hotel.find_by(id: params[:hotel_id])
    bookings = Booking.where('check_in_date >= ? AND check_out_date <= ? AND hotel_id = ?', check_in_date,
                             check_out_date, hotel.id)
    rooms = hotel.rooms
    find_available_room_types(bookings, rooms)

    respond_to do |format|
      format.json { render json: @available_room_type }
    end
  end

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

  def set_booking
    @booking = Booking.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to hotel_bookings_path, notice: e
  end

  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def create_and_send_notification(book)
    hotel = Hotel.find_by(id: @booking.hotel_id)
    content = "Booking #{book.booking_status}: for #{hotel.name} from #{book.check_in_date} to #{book.check_out_date}."
    notification = Notification.new(user_id: book.user_id, message: content, status: false)
    send_notification(notification) if notification.save
  end
end
