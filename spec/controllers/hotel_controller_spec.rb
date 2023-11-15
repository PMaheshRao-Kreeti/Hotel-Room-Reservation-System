# frozen_string_literal: true

#rubocop:disable all

require 'rails_helper'

RSpec.describe HotelsController, type: :controller do
  let(:super_admin) { FactoryBot.create(:user, role: :super_admin) }
  let(:hotel_admin) { FactoryBot.create(:user, role: :hotel_admin) }
  let(:customer) { FactoryBot.create(:user, role: :customer) }
  let(:valid_attributes) { FactoryBot.attributes_for(:hotel) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:hotel, name: '') }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:customer) { FactoryBot.create(:user, role: :customer, email: 'test1@example.com', phone: '8000000009') }

  before do
    allow(controller).to receive(:require_customer)
    allow(controller).to receive(:require_hotel_admin)
    allow(controller).to receive(:require_super_admin)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response for super admin' do
      get :new
      expect(response).to be_successful
    end
  end
  
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Hotel' do
        allow(controller).to receive(:current_user).and_return(super_admin)
        expect {
          post :create, params: { 
            hotel: {
              name:  'Sample Hotel' ,
            address:  '123 Main Street' ,
            city:  'Sample City' ,
            state:  'Sample State' ,
            country:  'Sample Country' ,
            pincode:  '12345' ,
            latitude:  42.123456 ,
            longitude:  -71.987654
            }
          }
          }.to change(Hotel, :count).by(1)
      end

      it 'redirects to the created hotel' do
        allow(controller).to receive(:current_user).and_return(super_admin)
        post :create, params: { hotel: valid_attributes }
        expect(response).to redirect_to(admin_management_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Hotel' do
        allow(controller).to receive(:current_user).and_return(super_admin)
        expect {
          post :create, params: { hotel: invalid_attributes }
        }.to change(Hotel, :count).by(0)
      end

      it 'renders the new template' do
        allow(controller).to receive(:current_user).and_return(super_admin)
        post :create, params: { hotel: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    context 'when hotel exists' do
      it 'returns a success response' do
        get :show, params: { id: hotel.id }
        expect(response).to be_successful
      end
    end

    context 'when hotel does not exist' do
      it 'redirects to hotels index' do
        get :show, params: { id: 'nonexistent_id' }
        expect(response).to redirect_to(hotels_path)
      end
    end
  end

  describe 'GET #show_rooms' do
    context 'when hotel exists' do
      it 'returns a success response' do
        get :show_rooms, params: { hotel_id: hotel.id }
        expect(response).to be_successful
      end
    end
  end

  describe 'GET #update' do
    context 'with valid parameters' do
      it 'updates the hotel' do
        allow(controller).to receive(:current_user).and_return(super_admin)
        hotel = FactoryBot.create(:hotel)
        new_name = 'Updated Hotel'
        session[:hotel_id] = hotel.id
        put :update, params: { id: hotel.id, hotel: { name: new_name } }
        hotel.reload
        expect(hotel.name).to eq(new_name)
      end
        
      it 'redirects to the updated hotel' do
        allow(controller).to receive(:current_user).and_return(super_admin)
        allow(controller).to receive(:current_user).and_return(super_admin)
        hotel = FactoryBot.create(:hotel)
        session[:hotel_id] = hotel.id
        put :update, params: { id: hotel.id, hotel: valid_attributes }
        expect(response).to redirect_to(hotel_path(hotel.id))
      end
    end

    context 'with invalid parameters' do
      it 'does not update the hotel' do
        allow(controller).to receive(:current_user).and_return(super_admin)        
        put :update, params: { id: hotel.id, hotel: invalid_attributes }
        hotel.reload
        expect(hotel.name).not_to eq(invalid_attributes[:name])
      end
    end
  end

  describe 'GET #search' do
    context 'when search query is not present' do
      it 'does not return any hotels' do
        allow(controller).to receive(:current_user).and_return(super_admin)

        get :search

        expect(assigns(:hotels)).to be_nil
        expect(response).to render_template(:search)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the hotel and redirects to hotels_path' do
      allow(controller).to receive(:current_user).and_return(super_admin)
      hotel_to_destroy = FactoryBot.create(:hotel)

      expect do
        delete :destroy, params: { id: hotel_to_destroy.id }
      end.to change(Hotel, :count).by(-1)

      expect(response).to redirect_to(hotels_path)
    end
  end
end

#rubocop:enable all