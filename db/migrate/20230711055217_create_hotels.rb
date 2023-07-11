class CreateHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :pincode
      t.text   :description
      t.string :hotel_image
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
