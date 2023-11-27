# frozen_string_literal: true

# Booking model represents a booking made by user
class Booking < ApplicationRecord
  before_create :set_booking_status_as_pending
  BOOKINGSTATUS = %w[approved rejected pending].freeze

  # association
  belongs_to :user
  belongs_to :hotel
  belongs_to :room, optional: true

  # validations
  validates :no_of_guest, presence: true, numericality: { greater_than: 0 }
  validates :guest_name, presence: true, length: { maximum: 255 }
  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :room_type, presence: true, inclusion: { in: ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'] }
  validates :booking_status, presence: true, inclusion: { in: %w[approved rejected pending cancelled] }
  validates :user_id, presence: true
  validates :hotel_id, presence: true
  validate :booking_duration_more_than_one_day

  default_scope { order(created_at: :desc) }

  scope :for_date_range_and_hotel, lambda { |check_in_date, check_out_date, hotel_id|
    where('check_in_date >= ? AND check_out_date <= ? AND hotel_id = ?', check_in_date, check_out_date, hotel_id)
  }

  scope :overlapping_dates, lambda { |check_in_date, check_out_date|
    where('check_in_date <= ? AND check_out_date >= ?', check_out_date, check_in_date)
  }

  scope :filter_by_hotel_and_roomtype, lambda { |hotel_id, room_type|
    where(hotel_id:, room_type:)
  }

  scope :current_user_bookings, lambda { |user_id|
    where(user_id:)
  }

  scope :for_hotel, lambda { |hotel_id|
    where(hotel_id:)
  }

  scope :excluding_cancelled, lambda {
    where.not(booking_status: 'cancelled')
  }

  scope :created_today, lambda {
    where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }

  # Combine scopes for @all_bookings
  scope :all_for_hotel, lambda { |hotel_id|
    for_hotel(hotel_id).excluding_cancelled
  }

  # Combine scopes for @todays_bookings
  scope :todays_for_hotel, lambda { |hotel_id|
    all_for_hotel(hotel_id).created_today
  }

  # Custom validation method
  def booking_duration_more_than_one_day
    errors.add(:check_out_date, 'must be greater than start date') if check_out_date < check_in_date

    return unless (check_out_date - check_in_date).to_i < 1

    errors.add(:base, 'Booking duration must be more than one day')
  end

  # callback method
  def set_booking_status_as_pending
    self.booking_status = 'pending'
  end
end
