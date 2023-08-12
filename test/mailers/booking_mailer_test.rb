# frozen_string_literal: true

require 'test_helper'

class BookingMailerTest < ActionMailer::TestCase
  test 'booking_done' do
    mail = BookingMailer.booking_done
    assert_equal 'Booking done', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end

  test 'booking_admin_action' do
    mail = BookingMailer.booking_admin_action
    assert_equal 'Booking admin action', mail.subject
    assert_equal ['to@example.org'], mail.to
    assert_equal ['from@example.com'], mail.from
    assert_match 'Hi', mail.body.encoded
  end
end
