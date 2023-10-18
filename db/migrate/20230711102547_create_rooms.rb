# frozen_string_literal: true

# Room database
class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :room_type, null: false
      t.string :room_number, null: false
      t.integer :price
      t.integer :capacity
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
# rubocop:enable all
