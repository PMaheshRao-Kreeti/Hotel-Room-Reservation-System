# frozen_string_literal: true

# Hotel model handle hotel releted data
class Hotel < ApplicationRecord
  before_destroy :reject_bookings_and_send_rejection_emails

  # hotel image attachment
  has_one_attached :hotel_image

  # association
  has_many :rooms, dependent: :destroy
  has_many :bookings, dependent: :nullify

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :state, presence: true, length: { maximum: 255 }
  validates :country, presence: true, length: { maximum: 80 }
  validates :pincode, presence: true, length: { maximum: 6 }
  validates :description, presence: true
  validates :hotel_image, presence: true
  validate :hotel_image_content_type
  validate :hotel_image_size
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.index_data
    __elasticsearch__.create_index! force: true
    __elasticsearch__.import
  end

  settings do
    mapping dynamic: 'false' do
      indexes :name
      indexes :address
      indexes :city
      indexes :state
    end
  end

  def as_indexed_json(_options = {})
    {
      name:,
      address:,
      city:,
      state:
    }
  end

  # rubocop:disable all
  def self.search_by_keyword(query)
    result = __elasticsearch__.search({
                                        query: {
                                          bool: {
                                            must: [
                                              {
                                                multi_match: {
                                                  query:,
                                                  fields: %i[name address city state]
                                                }
                                              }
                                            ]
                                          }
                                        }
                                      })
    result.records
  end
  # rubocop:enable all

  # custome validation
  def hotel_image_content_type
    return unless hotel_image.attached? && !hotel_image.content_type.in?(%w[image/jpeg image/png])

    errors.add(:hotel_image, 'must be a JPEG or PNG image')
  end

  def hotel_image_size
    return unless hotel_image.attached? && hotel_image.byte_size > 5.megabytes

    errors.add(:hotel_image, 'size must be less than 5MB')
  end

  # callback method for rejecting all booking request related to that hotel
  def reject_bookings_and_send_rejection_emails
    bookings.each do |booking|
      booking.update(booking_status: 'rejected', hotel_id: nil)
      BookingMailer.with(booking: @booking).booking_admin_action.deliver_later
    end
  end

  # full address of hotel
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
end
