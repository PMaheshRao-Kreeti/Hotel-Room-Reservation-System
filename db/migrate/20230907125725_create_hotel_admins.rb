# frozen_string_literal: true

# hotel admin table
class CreateHotelAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_admins do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
