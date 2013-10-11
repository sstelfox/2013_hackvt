class Incident
  include DataMapper::Resource

  property :id, Serial
  property :location_stolen,  String, length: 255
  property :reported_at, DateTime

  timestamps :at
end

