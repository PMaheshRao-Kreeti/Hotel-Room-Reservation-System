# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ----------------------------------------------------------------------------------------------------------------------


#----------------------------------------------------------------
# User account creation

User.create(
  name: 'Customer_1',
  email: 'customer1@gmail.com',
  phone: '7123456789',
  password: '12345',
  role: 1
)
User.create(
  name: 'Customer_2',
  email: 'customer2@gmail.com',
  phone: '8134567892',
  password: '12345',
  role: 1
)
User.create(
  name: 'Mahesh',
  email: 'maheshrao2002@gmail.com',
  phone: '9145678923',
  password: '12345',
  role: 1
)


# ----------------------------------------------------------------
# Admin accout acreation

User.create(
  name: 'Admin',
  email: 'admin@gmail.com',
  phone: '78451215415',
  password: 'admin',
  role: 0
)

# ----------------------------------------------------------------
# Hotel Creation
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
  address: 'Manindra Mitra Row, Shop No. 2C, Mahatma Gandhi Rd, Sealdah',
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

hotel = Hotel.new(
  name: 'OYO Hotel Sigma',
  address: '6, Road, Betore, Baksara',
  city: 'Howrah',
  state: 'West Bengal',
  country: 'India',
  pincode: '711104',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.582098883558377',
  longitude: '88.2991971686928'
)

hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/hotel_plaza.jpg')),
  filename: 'hotel_plaza.jpg'
)

hotel.save

hotel = Hotel.new(
  name: 'The Elegance',
  address: '544, Andul Rd, Podara, Mourigram',
  city: 'Howrah',
  state: 'West Bengal',
  country: 'India',
  pincode: '711109',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.5729593716015',
  longitude: '88.27079359798257'
)

hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)

hotel.save

hotel = Hotel.new(
  name: 'The Elegance',
  address: '544, Andul Rd, Podara, Mourigram',
  city: 'Howrah',
  state: 'West Bengal',
  country: 'India',
  pincode: '711109',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '22.5729593716015',
  longitude: '88.27079359798257'
)

hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)

hotel.save

hotel = Hotel.new(
  name: 'Hill Top Hotel',
  address: 'Idu line.R.B, RB Gurung Rd, Lebong',
  city: 'Darjeeling',
  state: 'West Bengal',
  country: 'India',
  pincode: '734105',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '27.06677486391306',
  longitude: '88.27760172082718'
)

hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)

hotel.save

hotel = Hotel.new(
  name: 'OYO Asansol Hotel',
  address: '229, lower, Chelidanga',
  city: 'Asansol',
  state: 'West Bengal',
  country: 'India',
  pincode: '713304',
  description: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Ab, in ea dolor asperiores placeat corporis possimus aliquam neque repudiandae voluptatum.',
  latitude: '23.691789951230895',
  longitude: '86.95888481053065'
)

hotel.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/FabExpress.jpg')),
  filename: 'FabExpress.jpg'
)

hotel.save
