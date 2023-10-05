# frozen_string_literal: true

# Room model handle hotels room releted data
class Room < ApplicationRecord
  before_validation :set_room_capacity

  # ROOMTYPES = ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'].freeze

  # associations
  belongs_to :hotel
  has_many :bookings

  # validations
  validates :room_type, presence: true, inclusion: { in: ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'] }
  validates :room_number, presence: true, length: { maximum: 5 }, uniqueness: { scope: :hotel_id }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :capacity, numericality: { greater_than: 0 }
  validates :hotel_id, presence: true

  # scope

  scope :room_prices, lambda { |room_type|
    where(room_type:)
      .order(:price)
      .pluck(:price)
      .presence || [0]
  }

  scope :filter_by_hotel_and_roomtype, lambda { |hotel_id, room_type|
    where(hotel_id:, room_type:)
  }

  scope :excluding_room_ids, lambda { |booked_room_ids|
    where.not(id: booked_room_ids)
  }

  # callback method for assigning capacity to room
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
