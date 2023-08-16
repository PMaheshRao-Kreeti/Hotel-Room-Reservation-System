# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ----------------------------------------------------------------------------------------------------------------------

#----------------------------------------------------------------

# rubocop:disable all

# db/seeds.rb

# ...

admin = User.new(
  name: 'Admin',
  email: 'admin@gmail.com',
  phone: '7845121545', 
  password: 'admin',
  role: 0
)
admin.save

customer = User.new(
  name: 'Mahesh',
  email: 'maheshrao2002@gmail.com',
  phone: '9145678923',
  password: 'mahesh',
  role: 1
)

customer.save

# ...

# ----------------------------------------------------------------
# Hotel Creation

hotel0 = Hotel.new(
  name: 'MONOTEL',
  address: 'Near Wipro Gate No 4, DM Block, Sec V, Bidhannagar',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700091',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.578280547224928',
  longitude: '88.42807586392954'
)
hotel0.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Monotel.jpg')),
  filename: 'Monotel.jpg'
)
hotel0.save


hotel1 = Hotel.new(
  name: 'Acco Plaza Ce 161 hotel',
  address: 'CE 161, Street No. 186',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700156',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.577670232493553',
  longitude: '88.45589430622393'
)
hotel1.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Acco_plaza.jpg')),
  filename: 'Acco_plaza.jpg'
)
hotel1.save

hotel2 = Hotel.new(
  name: 'FabExpress Aashi Inn',
  address: 'Street No. 12',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700156',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.57995933723397',
  longitude: '88.45094285417217'
)
hotel2.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/FabExpress.jpg')),
  filename: 'FabExpress.jpg'
)
hotel2.save

hotel3 = Hotel.new(
  name: 'Dorota House',
  address: 'FE-163, FE Block, Sector III, Bidhannagar',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700106',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.58155671472887',
  longitude: '88.41983422662163'
)
hotel3.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel3.save

hotel4 = Hotel.new(
  name: 'Midland Hotel',
  address: 'Manindra Mitra Row, Shop No. 2C, Mahatma Gandhi Rd, Sealdah',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700009',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.570590211077192',
  longitude: '88.36953726379731'
)
hotel4.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel4.save

hotel5 = Hotel.new(
  name: 'Hotel Plaza',
  address: '10 Sudder Street Fire Brigade, near walson hotel',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '711101',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.555920315868413',
  longitude: '88.35345328300798'
)
hotel5.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/hotel_plaza.jpg')),
  filename: 'hotel_plaza.jpg'
)
hotel5.save

hotel6 = Hotel.new(
  name: 'OYO Hotel Sigma',
  address: '6, Road, Betore, Baksara',
  city: 'Howrah',
  state: 'West Bengal',
  country: 'India',
  pincode: '711104',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.582098883558377',
  longitude: '88.2991971686928'
)
hotel6.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/hotel_plaza.jpg')),
  filename: 'hotel_plaza.jpg'
)
hotel6.save

hotel7 = Hotel.new(
  name: 'The Elegance',
  address: '544, Andul Rd, Podara, Mourigram',
  city: 'Howrah',
  state: 'West Bengal',
  country: 'India',
  pincode: '711109',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '22.5729593716015',
  longitude: '88.27079359798257'
)
hotel7.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel7.save

hotel8 = Hotel.new(
  name: 'Hill Top Hotel',
  address: 'Idu line.R.B, RB Gurung Rd, Lebong',
  city: 'Darjeeling',
  state: 'West Bengal',
  country: 'India',
  pincode: '734105',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '27.06677486391306',
  longitude: '88.27760172082718'
)
hotel8.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel8.save

hotel9 = Hotel.new(
  name: 'OYO Asansol Hotel',
  address: '229, lower, Chelidanga',
  city: 'Asansol',
  state: 'West Bengal',
  country: 'India',
  pincode: '713304',
  description: 'This is one of the beautiful and popular hotel, with large number of services avavilable.',
  latitude: '23.691789951230895',
  longitude: '86.95888481053065'
)
hotel9.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/FabExpress.jpg')),
  filename: 'FabExpress.jpg'
)
hotel9.save

#----------------------------------------------------------------

#Hotels Rooms Creation

(1..8).each do |id|  
  room = Room.new( room_type: 'Single Bed', room_number: '101', price: 199, capacity: 2,  hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save
  
  room = Room.new( room_type: 'Single Bed', room_number: '102', price: 199, capacity: 2, hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save
  room = Room.new( room_type: 'Double Bed', room_number: '201', price: 299, capacity: 4, hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save

  room = Room.new( room_type: 'Double Bed', room_number: '202', price: 299, capacity: 4,  hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save

  room = Room.new( room_type: 'Double Bed', room_number: '203', price: 299, capacity: 4,  hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save

  room = Room.new( room_type: 'Suite', room_number: '401', price: 399, capacity: 8, hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save

  room = Room.new( room_type: 'Suite', room_number: '402', price: 399, capacity: 8, hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save

  room = Room.new( room_type: 'Dormitory', room_number: '301', price: 499, capacity: 16, hotel_id: id )
  room.bedroom_image.attach(
    io: File.open(File.join(Rails.root, 'app/assets/images/bedroom/single_bedroom.jpg')),
    filename: 'single_bedroom.jpg'
  )
  room.save
end


# rubocop:enable all