class Hotel < ApplicationRecord
  

  has_one_attached :hotel_image

  has_many :rooms
  has_many :bookings

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
  validates :city, :state, :country, :pincode, :latitude, :longitude, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mapping dynamic: 'false' do
      indexes :name
      indexes :address
      indexes :city
      indexes :state
      indexes :country
      indexes :pincode
    end
  end

  def as_indexed_json(_options = {})
    {
      name:,
      address:,
      city:,
      state:,
      country:,
      pincode:
    }
  end


  def self.search_by_keyword(query)
    result =__elasticsearch__.search({
      query: {
        bool: {
          must: [
          {
            multi_match: {
              query: query,
              fields: [:name, :address, :city, :state, :country, :pincode]
            }
          }]
        }
      }
    })
    result.records
  end


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
