# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'securerandom'

# Some bullshit data:

# Create some damn users:
first_names = ['Sam', 'Gabe', 'Zach', 'Jared', 'Emily', 'Rebecca', 'Tobias',
  'Lindsay', 'George Michael', 'Finn']
last_names = ['Funke', 'Smith', 'Waters', 'Last Name']

def email
  "#{SecureRandom.hex(5)}@example.tld"
end

25.times do
  User.create(first_name: first_names.sample, last_name: last_names.sample,
    email: email, password: 'test', password_confirmation: 'test')
end

40.times do
  u = User.all.sample
  Bike.create(user: u, serial: SecureRandom.hex(10), frame_make: "A Company",
    frame_model: "A Bike", color: "Uncolored")
end

8.times do
  u = User.all.sample
  Incident.create(bike: u.bikes.sample, last_seen: 10.minutes.ago,
    last_location: "A place in burlington", latitude: "44.4#{rand(10000)}".to_f,
    longitude: "-73.2#{rand(10000)}".to_f)
end

