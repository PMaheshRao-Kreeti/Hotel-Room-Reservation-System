class BookingMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.booking_done.subject
  #

  def booking_done
    @booking = params[:booking]
    @user = User.find_by(id: @booking.user_id)
    @hotel = Hotel.find_by(id: @booking.hotel_id)

    mail(
      to: @user.email,
      subject: 'Booking is done Successfully'
    )
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.booking_admin_action.subject
  #
  def booking_admin_action
    @booking = params[:booking]
    @user = User.find_by(id: @booking.user_id)
    @hotel = Hotel.find_by(id: @booking.hotel_id)

    mail(
      to: @user.email,
      subject: 'Booking status is updated by Admin'
    )
  end
end
