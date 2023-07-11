# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ----------------------------------------------------------------------------------------------------------------------

# User and admin 1 role each

# user = User.create(
#   name: 'Mahesh',
#   email: 'mahesh@gmail.com',
#   phone: '7845121215',
#   password: '123',
#   role: 1
# )

# admin = Admin.create(
#   name: 'Admin',
#   email: 'admin@gmail.com',
#   phone: '78451215415',
#   password: 'admin',
#   role: 0
# )

hotel = Hotel.create(
  name: 'MONOTEL',
  address: 'Near Wipro Gate No 4, DM Block, Sec V, Bidhannagar',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700091',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.578280547224928',
  longitude: '88.42807586392954'
)

hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Monotel.jpg')),
  filename: 'Monotel.jpg'
)

hotel = Hotel.create(
  name: 'Acco Plaza Ce 161 hotel',
  address: 'CE 161, Street No. 186',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700156',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.577670232493553',
  longitude: '88.45589430622393'
)
hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Acco_plaza.jpg')),
  filename: 'Acco_plaza.jpg'
)

hotel = Hotel.create(
  name: 'FabExpress Aashi Inn',
  address: 'Street No. 12',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700156',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.57995933723397',
  longitude: '88.45094285417217'
)
hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/FabExpress.jpg')),
  filename: 'FabExpress.jpg'
)

hotel = Hotel.create(
  name: 'Dorota House',
  address: 'FE-163, FE Block, Sector III, Bidhannagar',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700106',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.58155671472887',
  longitude: '88.41983422662163'
)

hotel = Hotel.create(
  name: 'Midland Hotel',
  address: 'Manindra Mitra Row, Shop No. 2C, Mahatma Gandhi Rd, Sealdah,',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '700009',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.570590211077192',
  longitude: '88.36953726379731'
)
hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)

hotel = Hotel.create(
  name: 'Hotel Plaza',
  address: '10 Sudder Street Fire Brigade, near walson hotel',
  city: 'Kolkata',
  state: 'West Bengal',
  country: 'India',
  pincode: '711101',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.555920315868413',
  longitude: '88.35345328300798'
)
hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/hotel_plaza.jpg')),
  filename: 'hotel_plaza.jpg'
)
