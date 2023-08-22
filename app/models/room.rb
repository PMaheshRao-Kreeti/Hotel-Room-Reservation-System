# frozen_string_literal: true

# Room model handle hotels room releted data
class Room < ApplicationRecord
  before_validation :set_room_capacity, on: %i[create update]

  ROOMTYPES = ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'].freeze

  # room image attachment
  has_one_attached :bedroom_image

  # associations
  belongs_to :hotel
  has_many :bookings

  # validations
  validates :bedroom_image, presence: true
  validates :room_type, presence: true, inclusion: { in: ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'] }
  validates :room_number, presence: true, length: { maximum: 5 }, uniqueness: { scope: :hotel_id }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :capacity, numericality: { greater_than: 0 }
  validates :hotel_id, presence: true

  def set_room_capacity
    case room_type
    when 'Single Bed'
      self.capacity = 2
    when 'Double Bed'
      self.capacity = 4
    when 'Suite'
      self.capacity = 8
    when 'Dormitory'
      self.capacity = 16
    end
  end
end
