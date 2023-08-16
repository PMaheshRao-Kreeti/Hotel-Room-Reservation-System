# frozen_string_literal: true

#rubocop:disable all
# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'is invalid with an invalid email format' do
      user = FactoryBot.build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is invalid")
    end

    it 'is invalid with a duplicate email' do
      FactoryBot.create(:user, email: 'duplicate@example.com')
      user = FactoryBot.build(:user, email: 'duplicate@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it 'is invalid without a phone number' do
      user = FactoryBot.build(:user, phone: nil)
      expect(user).not_to be_valid
      expect(user.errors[:phone]).to include("can't be blank")
    end

    it 'is invalid with an invalid phone number format' do
      user = FactoryBot.build(:user, phone: '123')
      expect(user).not_to be_valid
      expect(user.errors[:phone]).to include("Invalid phone number format.")
    end

    it 'is invalid without a password' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'is invalid with a short password' do
      user = FactoryBot.build(:user, password: 'shor')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 5 characters)")
    end
  end

  # ... rest of the tests ...
end
#rubocop:enable all
