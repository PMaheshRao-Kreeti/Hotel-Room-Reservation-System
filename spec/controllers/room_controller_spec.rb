# frozen_string_literal: true

# rubocop:disable all
require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:hotel_admin) { FactoryBot.create(:user, role: :hotel_admin) }
  let(:hotel) { FactoryBot.create(:hotel) }
  let(:room) { FactoryBot.create(:room, hotel:) }

  before do
    allow(controller).to receive(:require_hotel_admin)
    allow(controller).to receive(:current_user).and_return(hotel_admin)
    
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new, params: { hotel_id: hotel.id }
      expect(response).to render_template(:new)
    end

    it 'assigns a new Room to @room' do
      get :new, params: { hotel_id: hotel.id }
      expect(assigns(:room)).to be_a_new(Room)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new room' do
        room_params = FactoryBot.attributes_for(:room, hotel_id: hotel.id,room_number: "105")
        expect do
          post :create, params: { hotel_id: hotel.id, room:  room_params}
        end.to change(Room, :count).by(1)
      end

      it 'redirects to hotel_show_rooms_path' do
        room_params = FactoryBot.attributes_for(:room, hotel_id: hotel.id,room_number: "105")
        post :create, params: { hotel_id: hotel.id, room: room_params }
        expect(response).to redirect_to(hotel_show_rooms_path(hotel))
      end
    end

    context 'with invalid parameters' do
      it 'renders the new template' do
        post :create, params: { hotel_id: hotel.id, room: { invalid: 'parameters' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { hotel_id: hotel.id, id: room.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the room' do
        new_room_type = 'Double Bed'
        patch :update, params: { hotel_id: hotel.id, id: room.id, room: { room_type: new_room_type } }
        room.reload
        expect(room.room_type).to eq(new_room_type)
      end

      it 'redirects to hotel_show_rooms_path' do
        patch :update, params: { hotel_id: hotel.id, id: room.id, room: FactoryBot.attributes_for(:room) }
        expect(response).to redirect_to(hotel_show_rooms_path(hotel))
      end
    end

    context 'with invalid parameters' do
      it 'renders the edit template' do
        patch :update, params: { hotel_id: hotel.id, id: room.id, room: { room_type: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to hotel_show_rooms_path' do
      delete :destroy, params: { hotel_id: hotel.id, id: room.id }
      expect(response).to redirect_to(hotel_show_rooms_path(hotel))
    end
  end
end

# rubocop:enable all