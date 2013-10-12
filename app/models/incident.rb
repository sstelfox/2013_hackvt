class Incident < ActiveRecord::Base
  belongs_to :bike
  validates_presence_of :last_seen, :last_location, :bike

  #geocoded_by :last_location
  #after_validaion :reverse_geocode
end
