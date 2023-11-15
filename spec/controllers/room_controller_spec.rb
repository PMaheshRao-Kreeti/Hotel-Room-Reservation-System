# frozen_string_literal: true

# spec/controllers/images_controller_spec.rb

# rubocop:disable all
require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  let(:hotel_admin) { FactoryBot.create(:user, role: :hotel_admin) }
  let(:hotel) { FactoryBot.create(:hotel) }

  before do
    allow(controller).to receive(:require_hotel_admin)
    allow(controller).to receive(:current_user).and_return(hotel_admin)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new HotelGalleryImage' do
      get :new
      expect(assigns(:hotel_gallery_image)).to be_a_new(HotelGalleryImage)
    end
  end

  describe 'POST #create' do
    hotel = FactoryBot.create(:hotel)
    let(:invalid_params) { { hotel_gallery_image: { image: nil, hotel_id: hotel.id } } }

    context 'with valid parameters' do
      it 'creates a new HotelGalleryImage' do
        expect do
          session[:hotel_id] = hotel.id
          post :create, params: { hotel_gallery_image: { image: fixture_file_upload('spec/support/sample_image.jpg', 'image/jpeg'), hotel_id: hotel.id }}
        end.to change(HotelGalleryImage, :count).by(1)
      end

      it 'redirects to the hotel show page' do
        session[:hotel_id] = hotel.id
        post :create, params: { hotel_gallery_image: { image: fixture_file_upload('spec/support/sample_image.jpg', 'image/jpeg'), hotel_id: hotel.id }}
        expect(response).to redirect_to(hotel_path(session[:hotel_id]))
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:hotel_gallery_image) { FactoryBot.create(:hotel_gallery_image, hotel: hotel) }

    it 'destroys the hotel gallery image' do
      expect do
        delete :destroy, params: { id: hotel_gallery_image.id }
      end.to change(HotelGalleryImage, :count).by(-1)
    end

    it 'redirects to the hotel show page' do
      delete :destroy, params: { id: hotel_gallery_image.id }
      expect(response).to redirect_to(hotel_path(hotel_gallery_image.hotel_id))
    end
  end
end

#rubocop: enable all