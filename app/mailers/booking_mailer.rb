# frozen_string_literal: true

require 'icalendar'
# Bookingmailer
class BookingMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.booking_done.subject
  #

  # rubocop:disable all
  def booking_done
    @booking = params[:booking]
    @user = User.find_by(id: @booking.user_id)
    @hotel = Hotel.find_by(id: @booking.hotel_id)

    mail(
      to: @user.email,
      subject: 'Booking is done Successfully'
    )
  end

  def booking_admin_action
    @booking = params[:booking]
    @user = User.find_by(id: @booking.user_id)
    @hotel = Hotel.find_by(id: @booking.hotel_id)

    if @booking.booking_status == 'approved'
      send_event_invitation(@user, @booking, @hotel)
    else
      mail(
      to: @user.email,
      subject: 'Booking status is Rejected by Admin'
    )
    end
  end

  
  
  def send_event_invitation(user, booking, hotel)
    ical = Icalendar::Calendar.new
    event = Icalendar::Event.new
    event.dtstart = Icalendar::Values::DateTime.new(booking.check_in_date)
    event.dtend = Icalendar::Values::DateTime.new(booking.check_out_date)
    event.organizer = "mailto:#{user.email}"
    event.organizer = Icalendar::Values::CalAddress.new("mailto:#{user.email}", cn: user.name)
    event.location = hotel.full_address
    event.summary = "#{user.name} | Your Booking Request is accepted by admin."
    ical.add_event(event)
    ical.append_custom_property('METHOD', 'PUBLISH')
    attachments['event.ics'] = { mime_type: 'text/calendar', content: ical.to_ical }
    mail(to: user.email, from: hotel.hotel_admin.user.email ,subject: 'Booking Confirmation')
  end

  

  # rubocop:enable all
end
