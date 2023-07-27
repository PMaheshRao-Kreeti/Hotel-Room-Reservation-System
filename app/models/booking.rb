class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  BOOKINGSTATUS = %w[approved rejected pending].freeze

  validates :no_of_guest,:guest_name, :room_type, presence: true
  validates :check_in_date, :check_out_date, presence: true
  validate :booking_duration_more_than_one_day

  # Custom validation method
  def booking_duration_more_than_one_day
    if check_out_date < check_in_date
      errors.add(:check_out_date, "must be greater than start date")
    end

    if (check_out_date - check_in_date).to_i < 1
      errors.add(:base, "Booking duration must be more than one day")
    end
  end
end
