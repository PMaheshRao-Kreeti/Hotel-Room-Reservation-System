# frozen_string_literal: true

# Hotel database
# rubocop:disable all
class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
      t.string :pincode, null: false
      t.text   :description
      t.string :hotel_image
      t.string :latitude, null: false
      t.string :longitude, null: false

      t.timestamps
    end
  end
end
# rubocop:enable all