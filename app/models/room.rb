# frozen_string_literal: true

# Room model handle hotels room releted data
class Room < ApplicationRecord
  belongs_to :hotel
  has_many :bookings

  ROOMTYPES = ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'].freeze
  AVAILABLEOPTION = ['Available', 'Not Available'].freeze

  has_one_attached :interior_image
  has_one_attached :exterior_image
  has_one_attached :bedroom_image

  validates :room_type, :price, :capacity, presence: true
  validates :room_number, presence: true, uniqueness: true
end
