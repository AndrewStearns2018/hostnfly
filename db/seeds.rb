# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Listing.destroy_all
Booking.destroy_all
Reservation.destroy_all

listing_1 = Listing.new(num_rooms: 2)
listing_1.save!

listing_2 = Listing.new(num_rooms: 3)
listing_2.save!

listing_3 = Listing.new(num_rooms: 5)
listing_3.save!

puts "3 listings created"

booking_1 = Booking.new(
  listing: Listing.first,
  start_date: Date.new(2019, 01, 01),
  end_date: Date.new(2019, 01, 10)
  )

booking_1.save!

puts "Created booking"

reservation_1 = Reservation.new(
  listing: Listing.first,
  start_date: Date.new(2019, 01, 01),
  end_date: Date.new(2019, 01, 05)
  )

reservation_1.save!

puts "DONE"
