# frozen_string_literal: true

# model handle hotel admin
class HotelAdmin < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :user_id, :hotel_id, presence: true
end
