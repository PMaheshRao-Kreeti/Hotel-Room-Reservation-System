# frozen_string_literal: true

# model handle hotel admin
class HotelAdmin < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :user_id, :hotel_id, presence: true

  scope :excluding_assigned_admin, lambda { |assigned_hotel_admin_id|
    where.not(id: assigned_hotel_admin_id)
  }
end
