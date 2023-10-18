# frozen_string_literal: true

# Booking database
# rubocop:disable all
class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :no_of_guest, null: false
      t.string :guest_name, null: false
      t.date :check_in_date, null: false
      t.date :check_out_date, null: false
      t.string :booking_status
      t.string :room_type, null: false
      t.string :hotel_name, null: false
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: true, foreign_key: true
      t.references :room, null: true, foreign_key: true

      t.timestamps
    end
  end
end
# rubocop:enable all
