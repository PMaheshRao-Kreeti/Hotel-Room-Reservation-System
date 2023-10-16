# frozen_string_literal: true

# Gallery image contoller
class ImagesController < ApplicationController
  before_action :require_hotel_admin

  def new
    @image = HotelGalleryImage.new
  end

  def create
    if HotelGalleryImage.create(
      image: params[:image],
      hotel_id: params[:hotel_id]
    )
      redirect_to hotel_path(session[:hotel_id]), notice: 'Image added to Gallery successfully'
    else
      render :new
    end
  end

  def destroy
    @hotel_gallery_image = HotelGalleryImage.find(params[:id])
    @hotel_gallery_image.image.purge
    @hotel_gallery_image.destroy

    redirect_to @hotel_gallery_image.hotel, alert: 'Gallery image was successfully deleted.'
  end
end
