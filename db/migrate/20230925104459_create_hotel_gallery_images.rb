# frozen_string_literal: true

# Gallery Image Table
class CreateHotelGalleryImages < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_gallery_images do |t|
      t.string :image
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
