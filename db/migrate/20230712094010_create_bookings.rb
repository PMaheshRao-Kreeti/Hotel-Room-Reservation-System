class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :no_of_guest, default: 1
      t.string :guest_name
      t.date :check_in_date
      t.date :check_out_date
      t.string :booking_status
      t.string :room_type
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.references :room, null: true, foreign_key: true

      t.timestamps
    end
  end
end
