class Room < ApplicationRecord
  belongs_to :hotel

  ROOMTYPES = ['Single Bed', 'Double bed', 'Suite', 'Dormitory'].freeze
  AVAILABLEOPTION = ['Available', 'Not Available'].freeze

  has_one_attached :interior_image
  has_one_attached :exterior_image
  has_one_attached :bedroom_image
  has_one_attached :outside_view_image
  has_one_attached :swimming_pool_image

  validates :room_type, :price, :capacity, :availability, presence: true
end
