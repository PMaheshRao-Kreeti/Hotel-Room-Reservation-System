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
  validate :bedroom_image_content_type
  validate :bedroom_image_size
  validates :room_type, presence: true, inclusion: { in: ['Single Bed', 'Double Bed', 'Suite', 'Dormitory'] }
  validates :room_number, presence: true, length: { maximum: 5 }, uniqueness: { scope: :hotel_id }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :capacity, numericality: { greater_than: 0 }
  validates :hotel_id, presence: true

  # custom validation
  def bedroom_image_content_type
    return unless bedroom_image.attached? && !bedroom_image.content_type.in?(%w[image/jpeg image/png])

    errors.add(:bedroom_image, 'must be a JPEG or PNG image')
  end

  def bedroom_image_size
    return unless bedroom_image.attached? && bedroom_image.byte_size > 5.megabytes

    errors.add(:bedroom_image, 'size must be less than 5MB')
  end

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
