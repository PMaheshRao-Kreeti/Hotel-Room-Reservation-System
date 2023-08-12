# frozen_string_literal: true

# Room model handle hotels room releted data
class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings

  ROOMTYPES = ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'].freeze
  AVAILABLEOPTION = ['Available', 'Not Available'].freeze

  has_one_attached :bedroom_image

  validates :bedroom_image, presence: true
  validates :room_type, presence: true, inclusion: { in: ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'] }
  validates :room_number, presence: true, length: { maximum: 50 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :hotel_id, presence: true
end
