class User < ApplicationRecord
  has_secure_password

  has_many :bookings
  has_many :notifications

  enum role: { admin: 0, customer: 1 }

  validates :name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :password, presence: true, length: { minimum: 5 }

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
end
