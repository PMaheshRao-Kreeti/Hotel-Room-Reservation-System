# frozen_string_literal: true

# spec/models/room_spec.rb
# rubocop:disable all
require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    it 'is invalid without hotel_id' do
      room = FactoryBot.build(:room)
      expect(room).not_to be_valid
    end

    it 'is invalid without a room_type' do
      room = FactoryBot.build(:room, room_type: nil)
      expect(room).not_to be_valid
      expect(room.errors[:room_type]).to include("can't be blank")
    end

    it 'is invalid with an invalid room_type' do
      room = FactoryBot.build(:room, room_type: 'invalid_type')
      expect(room).not_to be_valid
      expect(room.errors[:room_type]).to include("is not included in the list")
    end

    it 'is invalid without a room_number' do
      room = FactoryBot.build(:room, room_number: nil)
      expect(room).not_to be_valid
      expect(room.errors[:room_number]).to include("can't be blank")
    end

    it 'is invalid without a price' do
      room = FactoryBot.build(:room, price: nil)
      expect(room).not_to be_valid
      expect(room.errors[:price]).to include("can't be blank")
    end

    it 'is invalid with a non-positive price' do
      room = FactoryBot.build(:room, price: -100)
      expect(room).not_to be_valid
      expect(room.errors[:price]).to include("must be greater than 0")
    end

    it 'is invalid without a hotel_id' do
      room = FactoryBot.build(:room, hotel_id: nil)
      expect(room).not_to be_valid
      expect(room.errors[:hotel_id]).to include("can't be blank")
    end
  end
  describe '#set_room_capacity' do
    it 'sets the capacity for Single Bed' do
      room = FactoryBot.build(:room, room_type: 'Single Bed')
      room.set_room_capacity
      expect(room.capacity).to eq(2)
    end

    it 'sets the capacity for Double Bed' do
      room = FactoryBot.build(:room, room_type: 'Double Bed')
      room.set_room_capacity
      expect(room.capacity).to eq(4)
    end

    it 'sets the capacity for Suite' do
      room = FactoryBot.build(:room, room_type: 'Suite')
      room.set_room_capacity
      expect(room.capacity).to eq(8)
    end

    it 'sets the capacity for Dormitory' do
      room = FactoryBot.build(:room, room_type: 'Dormitory')
      room.set_room_capacity
      expect(room.capacity).to eq(16)
    end

    it 'does not set capacity for unknown room type' do
      room = FactoryBot.build(:room, room_type: 'Unknown Type')
      room.set_room_capacity
      expect(room.capacity).not_to be_nil
    end
  end

  describe '.room_prices' do
    it 'returns room prices for a specific room type' do
      # Create rooms with different prices and room types
      FactoryBot.create(:room, room_type: 'Suite', price: 100, room_number: '110')
      FactoryBot.create(:room, room_type: 'Suite', price: 120,  room_number: '111')
      prices = Room.room_prices('Suite')

      expect(prices).to eq([100, 120])
    end

    it 'returns [0] if no prices are available for the specified room type' do
      prices = Room.room_prices('Unknown Type')

      expect(prices).to eq([0])
    end
  end
end


#rubocop enable all