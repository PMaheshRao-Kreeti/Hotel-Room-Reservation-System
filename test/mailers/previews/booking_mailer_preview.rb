# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/booking_done
  def booking_done
    BookingMailer.booking_done
  end

  # Preview this email at http://localhost:3000/rails/mailers/booking_mailer/booking_admin_action
  def booking_admin_action
    BookingMailer.booking_admin_action
  end

end
