class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :interior_image
      t.string :exterior_image
      t.string :bedroom_image
      t.string :outside_view_image
      t.string :swimming_pool_image
      t.string :room_type
      t.integer :price
      t.integer :capacity
      t.string :availability
      t.references :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
