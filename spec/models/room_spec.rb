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
end


#rubocop enable all