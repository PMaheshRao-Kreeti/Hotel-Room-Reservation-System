# frozen_string_literal: true

# Booking model represents a booking made by user
class Booking < ApplicationRecord
  BOOKINGSTATUS = %w[approved rejected pending].freeze

  # association
  belongs_to :user
  belongs_to :hotel

  # validations
  validates :no_of_guest, presence: true, numericality: { greater_than: 0 }
  validates :guest_name, presence: true, length: { maximum: 255 }
  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :booking_status, presence: true, inclusion: { in: %w[approved pending rejected cancelled] }
  validates :room_type, presence: true, inclusion: { in: ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'] }
  validates :user_id, presence: true
  validates :hotel_id, presence: true
  validate :booking_duration_more_than_one_day

  # Custom validation method
  def booking_duration_more_than_one_day
    errors.add(:check_out_date, 'must be greater than start date') if check_out_date < check_in_date

    return unless (check_out_date - check_in_date).to_i < 1

    errors.add(:base, 'Booking duration must be more than one day')
  end
end
