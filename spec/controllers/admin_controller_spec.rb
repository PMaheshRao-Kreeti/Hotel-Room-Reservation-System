# frozen_string_literal: true

# spec/controllers/admins_controller_spec.rb

# rubocop:disable all

require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  let(:super_admin) { FactoryBot.create(:user, role: :super_admin) }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:hotel_admin) { FactoryBot.create(:user, role: :hotel_admin) }

  before do
    allow(controller).to receive(:require_super_admin)
  end

  describe 'GET #admin_index' do
    it 'returns a success response' do
      get :admin_index
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end
  end

  describe 'GET #hotel_admin_management' do
    it 'returns a success response' do
      get :hotel_admin_management
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { id: hotel.id }
      expect(response).to have_http_status(200) # Adjust status code based on your application logic
    end

    it 'assigns unassigned hotel admins to @not_assigned_hotel_admin_list' do
      not_assigned_hotel_admin = FactoryBot.create(:user, role: :hotel_admin, phone: '8974563215', email: 'test@superadmin.com')
      assigned_hotel_admin = FactoryBot.create(:user, role: :hotel_admin)
      HotelAdmin.create(hotel_id: hotel.id, user_id: assigned_hotel_admin.id)
      get :new, params: { id: hotel.id }
      templist= controller.instance_variable_get(:@not_assigned_hotel_admin_list)
      expect(templist).to include(not_assigned_hotel_admin)
      expect(templist).not_to include(assigned_hotel_admin)
    end
  end

  describe 'POST #create' do
    it 'creates a new hotel admin and redirects with a notice' do
      expect do
        post :create, params: { hotel_id: hotel.id, admin_id: hotel_admin.id }
      end.to change { HotelAdmin.count }.by(1)
      expect(response).to redirect_to(admin_management_path)
    end

    it 'renders the :new template if the creation fails' do
      allow(HotelAdmin).to receive(:create).and_return(false)
      post :create, params: { hotel_id: hotel.id, admin_id: hotel_admin.id }
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #destroy' do
    it 'destroys the hotel admin and redirects with a notice' do
      HotelAdmin.create(hotel_id: hotel.id, user_id: hotel_admin.id)
      expect do
        post :destroy, params: { id: hotel.id }
      end.to change { HotelAdmin.count }.by(-1)
      expect(response).to redirect_to(admin_management_path)
    end
  end
end

# rubocop:enable all
