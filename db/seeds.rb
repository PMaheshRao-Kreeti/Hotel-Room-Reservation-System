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
#----------------------------------------------------------------
# super admin account
super_admin = User.new(
  name: 'Super Admin',
  email: 'superadmin@gmail.com',
  phone: '9845121585', 
  password: 'superadmin',
  role: 0
)
super_admin.save

#----------------------------------------------------------------
# hotel admin account

admin1 = User.new(
  name: 'Monotel Admin',
  email: 'monoteladmin@gmail.com',
  phone: '8815121545', 
  password: 'password',
  role: 1
)
admin1.save

admin2 = User.new(
  name: 'Acco Plaza Admin',
  email: 'accoadmin@gmail.com',
  phone: '7825121545', 
  password: 'password',
  role: 1
)
admin2.save

admin3 = User.new(
  name: 'FabExpress Admin',
  email: 'fabexpressadmin@gmail.com',
  phone: '6845121545', 
  password: 'password',
  role: 1
)
admin3.save

admin4 = User.new(
  name: 'Doroto Admin',
  email: 'dorotoadmin@gmail.com',
  phone: '5845121545', 
  password: 'password',
  role: 1
)
admin4.save

admin5 = User.new(
  name: 'Midland Admin',
  email: 'midlandadmin@gmail.com',
  phone: '4845121545', 
  password: 'password',
  role: 1
)
admin5.save

admin6 = User.new(
  name: 'Hotel Plaza Admin',
  email: 'plazaadmin@gmail.com',
  phone: '3845121545', 
  password: 'password',
  role: 1
)
admin6.save

admin7 = User.new(
  name: 'Oyo Admin',
  email: 'oyoadmin@gmail.com',
  phone: '2845121545', 
  password: 'password',
  role: 1
)
admin7.save

admin8 = User.new(
  name: 'The Elegance Admin',
  email: 'eleganceadmin@gmail.com',
  phone: '1845121545', 
  password: 'password',
  role: 1
)
admin8.save

admin9 = User.new(
  name: 'Hill Top Admin',
  email: 'hilltopadmin@gmail.com',
  phone: '9045121545', 
  password: 'password',
  role: 1
)
admin9.save

admin10 = User.new(
  name: 'OYO Asansol Admin',
  email: 'oyoasansoladmin@gmail.com',
  phone: '9045121545', 
  password: 'password',
  role: 1
)
admin10.save


#----------------------------------------------------------------
# customer account

customer = User.new(
  name: 'User',
  email: 'user@gmail.com',
  phone: '9145678943',
  password: '12345',
  role: 2
)

customer.save

customer = User.new(
  name: 'Mahesh',
  email: 'mahesh@gmail.com',
  phone: '9145678923',
  password: 'mahesh',
  role: 2
)

customer.save

# ...

# ----------------------------------------------------------------
# Hotel Creation

hotel1 = Hotel.new(
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
hotel1.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Monotel.jpg')),
  filename: 'Monotel.jpg'
)
hotel1.save


hotel2 = Hotel.new(
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
hotel2.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Acco_plaza.jpg')),
  filename: 'Acco_plaza.jpg'
)
hotel2.save

hotel3 = Hotel.new(
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
hotel3.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/FabExpress.jpg')),
  filename: 'FabExpress.jpg'
)
hotel3.save

hotel4 = Hotel.new(
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
hotel4.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel4.save

hotel5 = Hotel.new(
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

hotel5.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/hotel_plaza.jpg')),
  filename: 'hotel_plaza.jpg'
)

hotel5.save

hotel6 = Hotel.new(
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
hotel6.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel6.save

hotel7 = Hotel.new(
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
hotel7.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/hotel_plaza.jpg')),
  filename: 'hotel_plaza.jpg'
)
hotel7.save

hotel8 = Hotel.new(
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
hotel8.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel8.save

hotel9 = Hotel.new(
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
hotel9.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/FabExpress.jpg')),
  filename: 'FabExpress.jpg'
)
hotel9.save

hotel10 = Hotel.new(
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
hotel10.hotel_image.attach(
  io: File.open(File.join(Rails.root, 'app/assets/images/hotel/Midland.jpg')),
  filename: 'Midland.jpg'
)
hotel10.save

#----------------------------------------------------------------

# HotelAdmin table user_id and hotel_id creation

HotelAdmin.create(user_id: admin1.id, hotel_id: hotel1.id)
HotelAdmin.create(user_id: admin2.id, hotel_id: hotel2.id)
# HotelAdmin.create(user_id: admin3.id, hotel_id: hotel3.id)
# HotelAdmin.create(user_id: admin4.id, hotel_id: hotel4.id)
HotelAdmin.create(user_id: admin5.id, hotel_id: hotel5.id)
HotelAdmin.create(user_id: admin6.id, hotel_id: hotel6.id)
# HotelAdmin.create(user_id: admin7.id, hotel_id: hotel7.id)
# HotelAdmin.create(user_id: admin8.id, hotel_id: hotel8.id)
# HotelAdmin.create(user_id: admin9.id, hotel_id: hotel9.id)
HotelAdmin.create(user_id: admin10.id, hotel_id: hotel10.id)


#----------------------------------------------------------------

#Hotels Rooms Creation

(1..8).each do |id|  
  room = Room.new( room_type: 'Single Bed', room_number: '101', price: 199, capacity: 2,  hotel_id: id )
  room.save
  
  room = Room.new( room_type: 'Single Bed', room_number: '102', price: 199, capacity: 2, hotel_id: id )
  room.save

  room = Room.new( room_type: 'Double Bed', room_number: '201', price: 299, capacity: 4, hotel_id: id )
  room.save

  room = Room.new( room_type: 'Double Bed', room_number: '202', price: 299, capacity: 4,  hotel_id: id )
  room.save

  room = Room.new( room_type: 'Double Bed', room_number: '203', price: 299, capacity: 4,  hotel_id: id )
  room.save

  room = Room.new( room_type: 'Suite', room_number: '401', price: 399, capacity: 8, hotel_id: id )
  room.save

  room = Room.new( room_type: 'Suite', room_number: '402', price: 399, capacity: 8, hotel_id: id )
  room.save

  room = Room.new( room_type: 'Dormitory', room_number: '301', price: 499, capacity: 16, hotel_id: id )
  room.save
end

# Booking.create(
#   no_of_guest: 2,
#   guest_name: "Alice",
#   check_in_date: Date.tomorrow + 2,
#   check_out_date: Date.tomorrow + 3,
#   booking_status: "pending",
#   room_type: "Single Bed",
#   hotel_name: "MONOTEL",
#   user_id: 11,
#   hotel_id: 1,
#   room: 1
# )

# Booking.create(
#   no_of_guest: 4,
#   guest_name: "Damen",
#   check_in_date: Date.tomorrow + 4,
#   check_out_date: Date.tomorrow + 5,
#   booking_status: "pending",
#   room_type: "Double Bed",
#   hotel_name: "MONOTEL",
#   user_id: 11,
#   hotel_id: 1,
#   room: 3
# )
# Booking.create(
#   no_of_guest: 8,
#   guest_name: "Dizy",
#   check_in_date: Date.tomorrow + 6,
#   check_out_date: Date.tomorrow + 7,
#   booking_status: "pending",
#   room_type: "Double Bed",
#   hotel_name: "MONOTEL",
#   user_id: 11,
#   hotel_id: 1,
#   room_id: 4
# )
# rubocop:enable all