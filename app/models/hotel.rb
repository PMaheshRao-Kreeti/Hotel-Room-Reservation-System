class Hotel < ApplicationRecord
  has_one_attached :hotel_image

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
  validates :city, :state, :country, :pincode, :latitude, :longitude, presence: true

  def full_address
    "#{address}, #{city}, #{state}, #{country} - #{pincode}".strip
  end
end
