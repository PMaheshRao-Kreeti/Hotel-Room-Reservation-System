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

  describe 'methods' do
    let(:hotel) { FactoryBot.create(:hotel) }

    it 'returns the full address' do
      expect(hotel.full_address).to eq("#{hotel.address}, #{hotel.city}, #{hotel.state}, #{hotel.country} - #{hotel.pincode}".strip)
    end
  end
end

#rubocop:enable all
