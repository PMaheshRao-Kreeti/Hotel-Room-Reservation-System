# frozen_string_literal: true

#rubocop:disable all
# spec/models/hotel_spec.rb
require 'rails_helper'

RSpec.describe Hotel, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      hotel = FactoryBot.build(:hotel)
      expect(hotel).to be_valid
    end

    it 'is invalid without a name' do
      hotel = FactoryBot.build(:hotel, name: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an address' do
      hotel = FactoryBot.build(:hotel, address: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:address]).to include("can't be blank")
    end

    it 'is invalid without a city' do
      hotel = FactoryBot.build(:hotel, city: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:city]).to include("can't be blank")
    end

    it 'is invalid without a state' do
      hotel = FactoryBot.build(:hotel, state: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:state]).to include("can't be blank")
    end

    it 'is invalid without a country' do
      hotel = FactoryBot.build(:hotel, country: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:country]).to include("can't be blank")
    end

    it 'is invalid without a pincode' do
      hotel = FactoryBot.build(:hotel, pincode: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:pincode]).to include("can't be blank")
    end

    it 'is invalid without a latitude' do
      hotel = FactoryBot.build(:hotel, latitude: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:latitude]).to include("can't be blank")
    end

    it 'is invalid without a longitude' do
      hotel = FactoryBot.build(:hotel, longitude: nil)
      expect(hotel).not_to be_valid
      expect(hotel.errors[:longitude]).to include("can't be blank")
    end 
  end

  describe 'callbacks' do
    describe '#address_titleize' do
      it 'titleizes address fields before saving' do
        hotel = FactoryBot.build(:hotel)
        hotel.update(
          address: '123 main St',
          city: 'new york',
          state: 'ny',
          country: 'usa'
        )

        expect(hotel.address).to eq('123 Main St')
        expect(hotel.city).to eq('New York')
        expect(hotel.state).to eq('Ny')
        expect(hotel.country).to eq('Usa')
      end
    end
  end

   describe '.filter_by_destination' do
    it 'returns hotels with the specified city' do
      hotel1 = FactoryBot.create(:hotel, city: 'City1')
      FactoryBot.create(:hotel, city: 'City2')

      result = Hotel.filter_by_destination('City1')

      expect(result).to contain_exactly(hotel1)
    end
  end


  describe '#hotel_image_size' do
    context 'when hotel image is within size limit' do
      it 'does not add an error' do
        hotel = FactoryBot.build(:hotel, hotel_image: fixture_file_upload('spec/support/sample_image.jpg', 'image/jpeg'))
        hotel.valid?
        expect(hotel.errors[:hotel_image]).to be_empty
      end
    end

    context 'when hotel image exceeds size limit' do
      it 'adds an error' do
        hotel = FactoryBot.build(:hotel, hotel_image: fixture_file_upload('spec/support/sample_image_2.jpg', 'image/jpeg'))
        hotel.valid?
        expect(hotel.errors[:hotel_image]).to include('size must be less than 5MB')
      end
    end

    context 'when hotel image is not attached' do
      it 'does not add an error' do
        hotel = FactoryBot.build(:hotel, hotel_image: nil)
        hotel.valid?
        expect(hotel.errors[:hotel_image]).to be_empty
      end
    end
  end

  describe 'Validations' do
    describe '#hotel_image_content_type' do
      let(:hotel) { FactoryBot.build(:hotel) }

      context 'when hotel image is a JPEG' do
        before do
          file = fixture_file_upload(Rails.root.join('spec', 'support', 'sample_image.jpg'), 'image/jpeg')
          hotel.hotel_image.attach(file)
        end

        it 'is valid' do
          expect(hotel).to be_valid
        end
      end

      context 'when hotel image is a PNG' do
        before do
          file = fixture_file_upload(Rails.root.join('spec', 'support', 'sample_image_1.png'), 'image/png')
          hotel.hotel_image.attach(file)
        end

        it 'is valid' do
          expect(hotel).to be_valid
        end
      end

      context 'when hotel image is not a JPEG or PNG' do
        before do
          file = fixture_file_upload(Rails.root.join('spec', 'support', 'sample_image_3.pdf'), 'application/pdf')
          hotel.hotel_image.attach(file)
        end

        it 'is not valid' do
          expect(hotel).not_to be_valid
          expect(hotel.errors[:hotel_image]).to include('must be a JPEG or PNG image')
        end
      end
    end
  end

  describe '#full_address' do
    it 'returns the full address string' do
      hotel = FactoryBot.build(:hotel)
      full_address = "#{hotel.address}, #{hotel.city}, #{hotel.state}, #{hotel.country} - #{hotel.pincode}"
      expect(hotel.full_address).to eq(full_address.strip)
    end
  end

  describe '#total_rooms_count' do
    it 'returns the total count of rooms for a specific type' do
      hotel = FactoryBot.create(:hotel)
      room_type = 'Single Bed'
      
      # Instead of using the same room_type, create rooms with different attributes
      FactoryBot.create(:room, hotel: hotel, room_type: room_type, room_number: '102')
      FactoryBot.create(:room, hotel: hotel, room_type: room_type, room_number: '103')
      FactoryBot.create(:room, hotel: hotel, room_type: room_type, room_number: '104')

      expect(hotel.total_rooms_count(room_type)).to eq(3)
    end
  end

  describe '#booked_rooms_count' do
    it 'returns the count of booked rooms for a specific type within a date range' do
      hotel = FactoryBot.create(:hotel)
      room_type = 'Single Bed'
      checkin = Date.today
      checkout = Date.tomorrow
      FactoryBot.create(:booking, hotel: hotel, room_type: 'Single Bed', check_in_date: checkin, check_out_date: checkout)
      expect(hotel.booked_rooms_count(checkin, checkout, room_type)).to eq(1)
    end
  end

  describe '#available_rooms_count' do
    it 'returns the count of available rooms for a specific type and date range' do
      hotel = FactoryBot.create(:hotel)
      room_type = 'Single Bed'
      FactoryBot.create(:room, hotel: hotel, room_type: room_type, room_number: '102')
      FactoryBot.create(:room, hotel: hotel, room_type: room_type, room_number: '103')
      FactoryBot.create(:room, hotel: hotel, room_type: room_type, room_number: '104')
      checkin = Date.today
      checkout = Date.tomorrow
      FactoryBot.create(:booking, hotel: hotel, room_type: room_type, check_in_date: checkin, check_out_date: checkout)
      expect(hotel.available_rooms_count(checkin, checkout, room_type)).to eq(2)
    end
  end

  describe '#max_room_price' do
    it 'returns the maximum price among all rooms' do
      hotel = FactoryBot.create(:hotel)
      FactoryBot.create(:room, hotel: hotel, price: 100,  room_number: '102')
      FactoryBot.create(:room, hotel: hotel, price: 150,  room_number: '103')
      FactoryBot.create(:room, hotel: hotel, price: 120,  room_number: '104')
      expect(hotel.max_room_price).to eq(150)
    end

    it 'returns nil when there are no rooms' do
      hotel = FactoryBot.create(:hotel)
      expect(hotel.max_room_price).to be_nil
    end
  end

  describe '#min_room_price' do
    it 'returns the minimum price among all rooms' do
      hotel = FactoryBot.create(:hotel)
      FactoryBot.create(:room, hotel: hotel, price: 100,  room_number: '102')
      FactoryBot.create(:room, hotel: hotel, price: 150,  room_number: '103')
      FactoryBot.create(:room, hotel: hotel, price: 120,  room_number: '104')
      expect(hotel.min_room_price).to eq(100)
    end

    it 'returns nil when there are no rooms' do
      hotel = FactoryBot.create(:hotel)
      expect(hotel.min_room_price).to be_nil
    end
  end
end

#rubocop:enable all
