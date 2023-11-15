# frozen_string_literal: true

# spec/controllers/bookings_controller_spec.rb
# rubocop:disable all
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:booking) { FactoryBot.create(:booking, user: user, hotel: hotel) }
  let(:customer) { FactoryBot.create(:user, role: :customer, email: 'test1@example.com', phone: '8000000009') }

  before do
    allow(controller).to receive(:require_customer)
    allow(controller).to receive(:require_hotel_admin)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end
  end

  describe 'GET #booking_history' do
    it 'returns a success response' do
      allow(controller).to receive(:current_user).and_return(customer)
      get :booking_history
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      allow(controller).to receive(:current_user).and_return(customer)
      get :new, params: { hotel_id: hotel.id }
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end
  end

  describe 'POST #create' do
      before do
        session[:user_id]=user.id
      end
    it 'creates a new booking and redirects with a notice' do
      expect do
        allow(controller).to receive(:current_user).and_return(customer)
        post :create, params: { booking:  FactoryBot.attributes_for(:booking), hotel_id: hotel.id }
      end.to change { Booking.count }.by(1)
      expect(response).to redirect_to(bookings_history_path)
    end

    it 'renders the :new template if the creation fails' do
      allow(controller).to receive(:current_user).and_return(customer)
      post :create, params: { booking:  FactoryBot.attributes_for(:booking,guest_name: nil), hotel_id: hotel.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #approval' do
    it 'returns a success response' do
      get :approval, params: { id: booking.id, hotel_id: hotel.id }
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end
  end

  describe 'GET #details' do
    it 'returns a success response' do
      get :details, params: { hotel_id: hotel.id }
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end

    # Add more tests for other aspects of the details action as needed
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: booking.id, hotel_id: hotel.id }
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end

    # Add more tests for other aspects of the show action as needed
  end

  describe 'PATCH #update' do
    let(:new_status) { 'approved' }

    it 'updates the booking status and redirects' do
      patch :update, params: { id: booking.id, hotel_id: hotel.id, booking: { booking_status: new_status } }
      expect(response).to redirect_to(bookings_path)
      expect(booking.reload.booking_status).to eq(new_status)
    end

    it 'renders the approval template if update fails' do
      # Stubbing necessary methods or providing required data for testing
      allow_any_instance_of(Booking).to receive(:update).and_return(false)

      patch :update, params: { id: booking.id, hotel_id: hotel.id, booking: { booking_status: new_status } }
      expect(response).to render_template(:approval)
    end

    # Add more tests for other aspects of the update action as needed
  end

  describe 'GET #cancelled' do
    it 'cancels the booking and redirects' do
      get :cancelled, params: { id: booking.id, hotel_id: hotel.id }
      expect(response).to redirect_to(bookings_history_path)
      expect(booking.reload.booking_status).to eq('cancelled')
      expect(booking.room_id).to be_blank
    end

    # Add more tests for other aspects of the cancelled action as needed
  end

  describe 'POST #markread' do
    it 'marks notifications as read' do
      notification = FactoryBot.create(:notification, :read, user: user)
      post :markread, params: { selected_btn: user.id }
      expect(notification.reload.status).to be_truthy
    end

    # Add more tests for other aspects of the markread action as needed
  end
end
# rubocop:enable all