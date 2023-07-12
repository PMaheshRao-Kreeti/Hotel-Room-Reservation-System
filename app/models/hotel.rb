class Hotel < ApplicationRecord
  has_one_attached :hotel_image

  has_many :rooms

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
  validates :city, :state, :country, :pincode, :latitude, :longitude, presence: true

  def full_address
    "#{address}, #{city}, #{state}, #{country} - #{pincode}".strip
  end

  # method for fining maximum and minimum price
  def max_room_price
    rooms.maximum(:price)
  end

  def min_room_price
    rooms.minimum(:price)
  end

  # in helper method no of room avaialable method present
end
