# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

EventPlace.destroy_all
Place.destroy_all
Event.destroy_all

# Seed data for Places
3.times do
  Place.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.phone_number,
    category: Faker::Lorem.word,
    second_category: Faker::Lorem.word,
    third_category: Faker::Lorem.word,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    distance: Faker::Number.decimal(l_digits: 2),
    opening_hours: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    rating: Faker::Number.between(from: 1, to: 5)
  )
end

# Seed data for Events
3.times do
  Event.create!(
    user_id: 3,
    name: Faker::Lorem.word,
    barycenter_lng: Faker::Address.longitude,
    barycenter_lat: Faker::Address.latitude,
    date: Faker::Date.forward(days: 23),
    start_time: Faker::Time.forward(days: 23),
    status: Event::STATUS.sample
  )
end

# Seed data for EventPlaces (linking Events and Places)
events = Event.all
places = Place.all

events.each do |event|
  event_place = EventPlace.create!(
    duration: Faker::Number.number(digits: 2),
    distance: Faker::Number.decimal(l_digits: 2),
    transport_mode: Faker::Lorem.word,
    selected: [true, false].sample,
    place: places.sample,
    event: event
  )
end


puts 'Creating fake users'

lucile = User.create(first_name: "Lucile", last_name: "Smith", nickname: "Lucile", email: "lucile@idealplace.com", password: "123456", address: "15, rue Oberkampf 75010 Paris")
arthur = User.create(first_name: "Arthur", last_name: "Johnson", nickname:"Arthur", email: "arthur@idealplace.com", password: "123456", address:"16, rue Oberkampf 75010 Paris")
abdelsam = User.create(first_name: "Abdelsam", last_name: "Palmas", nickname:"Abdelsam", email: "abdelsam@idealplace.com", password: "123456", address: "18, avenue de Paris 93123 Montreuil")
laure = User.create(first_name: "Laure", last_name: "Vega", nickname:"Laure", email: "laure@idealplace.com", password: "123456", address: "17, rue Cart 94160 Saint-Mandé")
timothee = User.create(first_name: "Timothée", last_name:"Dupont", nickname:"Timothée", email: "timothee@idealplace.com", password: "123456", address: "15, Cours de Vincennes 94300 Vincennes")
lucas = User.create(first_name: "Lucas", last_name:"Durand", nickname:"Lucas", email: "lucas@idealplace.com", password: "123456", address: "18, avenue Parmentier 75003 Paris")
kim = User.create(first_name: "Kim", last_name: "Jérémy", nickname: "Kim", email: "kim@idealplace.com", password: "123456", address: "20, avenue des pastéques 94300 Vincennes")
edward = User.create(first_name: "Edward", last_name: "Niceguy", nickname:"Niceguy", email: "edward@idealplace.com", password: "123456", address: "21, rue des melons 94300 Vincennes")

group1 = Group.create(name: "groupe1", user_id: arthur.id)
GroupUser.create(user_id: arthur.id, group_id: group1.id)
GroupUser.create(user_id: laure.id, group_id: group1.id)

puts 'Seed creation is over!'

