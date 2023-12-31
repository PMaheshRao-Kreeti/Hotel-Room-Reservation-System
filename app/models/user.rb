# frozen_string_literal: true

# User model handle User data
class User < ApplicationRecord
  has_secure_password

  has_one :hotel_admin
  has_many :bookings
  has_many :notifications

  enum role: { super_admin: 0, hotel_admin: 1, customer: 2 }

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'Invalid eamil id format' }
  validates :phone, presence: true, uniqueness: true, length: { is: 10 },
                    format: { with: /\A[6-9]\d{9}\z/, message: 'Invalid phone number format.' }
  validates :password, presence: true, length: { minimum: 5 }

  # scope

  scope :excluding_assigned_admin, lambda { |assigned_hotel_admin_id|
    where.not(id: assigned_hotel_admin_id)
  }

  # rubocop:disable all
  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email)
    return user if user

    where(provider: auth.provider, uid: auth.uid).first_or_create do |new_user|
      new_user.provider = auth.provider
      new_user.uid = auth.uid
      new_user.name = auth.info.name
      new_user.email = auth.info.email
      new_user.password = SecureRandom.hex(16)
      new_user.role = :customer
    end
  end
  # rubocop:enable all
end
