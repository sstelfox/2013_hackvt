class Bike
  include DataMapper::Resource

  property :id,     Serial

  property :serial,           String , length: 255
  property :make,             String , length: 255
  property :model,            String , length: 255
  property :size,             String , length: 255
  property :color,            String , length: 255
  property :status,           String , length: 255
  property :location_found,   String , length: 255
  property :location_stolen,  String , length: 255
  property :owner_first_name, String , length: 255
  property :owner_last_name,  String , length: 255
  property :owner_email,      String , length: 255
  property :owner_phone,      String , length: 255

  timestamps :at

end

