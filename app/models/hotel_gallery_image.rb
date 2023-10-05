# frozen_string_literal: true

# Gallery images
class HotelGalleryImage < ApplicationRecord
  belongs_to :hotel
  has_one_attached :image
end
