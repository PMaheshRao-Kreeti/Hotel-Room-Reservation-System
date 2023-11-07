# frozen_string_literal: true

#rubocop:disable all
require 'rails_helper'

# spec/models/booking_spec.rb

RSpec.describe Booking, type: :model do

  
  describe 'associations' do
    it 'belongs to a user' do
      association = Booking.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a hotel' do
      association = Booking.reflect_on_association(:hotel)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      booking = FactoryBot.build(:booking)
      expect(booking).not_to be_valid
    end

    it 'is invalid without no_of_guest' do
      booking = FactoryBot.build(:booking, no_of_guest: nil)
      expect(booking).not_to be_valid
      expect(booking.errors[:no_of_guest]).to include("can't be blank")
    end

    it 'is invalid without guest_name' do
      booking = FactoryBot.build(:booking, guest_name: nil)
      expect(booking).not_to be_valid
      expect(booking.errors[:guest_name]).to include("can't be blank")
    end
    
    it 'is invalid without booking_status' do
      booking = FactoryBot.build(:booking, booking_status: nil)
      expect(booking).not_to be_valid
      expect(booking.errors[:booking_status]).to include("can't be blank")
    end

    it 'is invalid with an invalid booking_status' do
      booking = FactoryBot.build(:booking, booking_status: 'invalid_status')
      expect(booking).not_to be_valid
      expect(booking.errors[:booking_status]).to include("is not included in the list")
    end

    it 'is invalid without room_type' do
      booking = FactoryBot.build(:booking, room_type: nil)
      expect(booking).not_to be_valid
      expect(booking.errors[:room_type]).to include("can't be blank")
    end

    it 'is invalid with an invalid room_type' do
      booking = FactoryBot.build(:booking, room_type: 'invalid_type')
      expect(booking).not_to be_valid
      expect(booking.errors[:room_type]).to include("is not included in the list")
    end

    it 'is invalid without user_id' do
      booking = FactoryBot.build(:booking, user_id: nil)
      expect(booking).not_to be_valid
      expect(booking.errors[:user_id]).to include("can't be blank")
    end

    it 'is invalid without hotel_id' do
      booking = FactoryBot.build(:booking, hotel_id: nil)
      expect(booking).not_to be_valid
      expect(booking.errors[:hotel_id]).to include("can't be blank")
    end

    it 'is invalid when booking duration is less than one day' do
      booking = FactoryBot.build(:booking, check_in_date: Date.today, check_out_date: Date.today)
      expect(booking).not_to be_valid
      expect(booking.errors[:base]).to include('Booking duration must be more than one day')
    end

    it 'is invalid when check_out_date is before check_in_date' do
      booking = FactoryBot.build(:booking, check_in_date: Date.new(2023, 8, 10), check_out_date: Date.new(2023, 8, 5))
      expect(booking).not_to be_valid
      expect(booking.errors[:check_out_date]).to include('must be greater than start date')
    end
  end
end

#rubocop:enable all