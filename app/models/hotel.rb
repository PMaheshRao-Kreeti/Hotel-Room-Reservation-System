# frozen_string_literal: true

# Hotel model handle hotel releted data
# rubocop:disable all
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
  
  scope :filter_by_no_of_guests, lambda { |no_of_guest, hotels, checkin = Date.today, checkout = Date.tomorrow |
    guest_filter(no_of_guest, hotels, checkin, checkout)
  }
  
  scope :filter_by_no_of_rooms, lambda { |no_of_room, hotels, checkin = Date.today, checkout = Date.tomorrow |
    room_count_filter(no_of_room, hotels, checkin, checkout)
  }

  def self.guest_filter(no_of_guest, hotels, checkin, checkout)
    @remove_hotel_id = []
    hotels.each do |hotel|
      @guest_count = 0
      @guest_count = 2 * hotel.available_rooms_count(checkin, checkout, 'Single Bed') +
                    4 * hotel.available_rooms_count(checkin, checkout, 'Double Bed') +
                    8 * hotel.available_rooms_count(checkin, checkout, 'Suite') +
                    16 * hotel.available_rooms_count(checkin, checkout, 'Dormitory')
      
      @remove_hotel_id << hotel if @guest_count < no_of_guest
    end
    hotels = hotels.where.not(id: @remove_hotel_id)
    return hotels
  end

  def self.room_count_filter(no_of_room, hotels, checkin, checkout)
    @remove_hotel_id = []
    hotels.each do |hotel|
      @room_count = 0
      @room_count = hotel.available_rooms_count(checkin, checkout, 'Single Bed') +
                     hotel.available_rooms_count(checkin, checkout, 'Double Bed') +
                     hotel.available_rooms_count(checkin, checkout, 'Suite') +
                     hotel.available_rooms_count(checkin, checkout, 'Dormitory')
      
      @remove_hotel_id << hotel if @room_count < no_of_room
    end
    hotels = hotels.where.not(id: @remove_hotel_id)
    return hotels
  end

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

  
  # callback method for rejecting all booking request related to that hotel
  def reject_bookings_and_send_rejection_emails
    bookings.each do |booking|
      booking.update(booking_status: 'rejected', hotel_id: nil, room_id: nil)
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
  def total_rooms_count(type)
    rooms.where('room_type = ?',type).count
  end

  def booked_rooms_count(checkin, checkout, type)
    bookings.where('((?<= check_in_date  AND  ?  > check_in_date) OR
      (?<= check_out_date)) AND room_type = ?', checkin, checkout,checkin, type).count
  end

  def available_rooms_count( checkin, checkout, type )
    total_rooms_count(type) - booked_rooms_count(checkin, checkout, type)
  end
  
  def max_room_price
    rooms.maximum(:price)
  end
  
  def min_room_price
    rooms.minimum(:price)
  end
end

# rubocop:enable all