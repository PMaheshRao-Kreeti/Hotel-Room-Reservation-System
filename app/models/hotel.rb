# frozen_string_literal: true

# Hotel model handle hotel releted data
class Hotel < ApplicationRecord
  before_destroy :reject_bookings_and_send_rejection_emails
  before_save :address_titleize

  # RoomType available [Single Bed , Double Bed , Suite , Dormitory] for coding help
  # hotel image attachment
  has_one_attached :hotel_image

  # association
  has_one :hotel_admin
  has_many :hotel_gallery_images, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :bookings, dependent: :nullify

  # Validations
  validates :name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :state, presence: true, length: { maximum: 255 }
  validates :country, presence: true, length: { maximum: 80 }
  validates :pincode, presence: true, length: { maximum: 6 }
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :description, presence: true, on: :update
  validates :hotel_image, presence: true, on: :update
  validate :hotel_image_content_type
  validate :hotel_image_size

  default_scope { order(created_at: :asc) }

  scope :filter_by_destination, lambda { |city|
    where(city: city)
  }

  scope :filter_by_no_of_guests, lambda { |no_of_guest|
    joins(:rooms)
      .group('hotels.id')
      .having('SUM(rooms.capacity) > ?', no_of_guest)
  }

  scope :filter_by_no_of_rooms, lambda { |no_of_room|
    joins(:rooms)
      .group('hotels.id')
      .having('COUNT(rooms.id) > ?', no_of_room)
  }


  # custome validation
  def hotel_image_content_type
    return unless hotel_image.attached? && !hotel_image.content_type.in?(%w[image/jpeg image/png])

    errors.add(:hotel_image, 'must be a JPEG or PNG image')
  end

  def hotel_image_size
    return unless hotel_image.attached? && hotel_image.byte_size > 5.megabytes

    errors.add(:hotel_image, 'size must be less than 5MB')
  end

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
    wildcards_query = query.split.map { |term| "*#{term}*" }.join(' ')
    result = __elasticsearch__.search({
                                        query: {
                                          bool: {
                                            must: [
                                              {
                                                query_string:{
                                                   query:wildcards_query,
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

  # callback method for rejecting all booking request related to that hotel
  def reject_bookings_and_send_rejection_emails
    bookings.each do |booking|
      booking.update(booking_status: 'rejected', hotel_id: nil)
      BookingMailer.with(booking: @booking).booking_admin_action.deliver_later
    end
  end

  def address_titleize
    self.address = address.downcase.titleize
    self.city = city.downcase.titleize
    self.state = state.downcase.titleize
    self.country = country.downcase.titleize
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
