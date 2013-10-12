
class IncidentForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Incident")
  end

  validate :verify_bike_record
  validate :verify_incident_record
    
 delegate :serial, :frame_make, :frame_model, :color, :description, to: :bike
 delegate :last_seen, :last_location, :police_incident_number, :officer_name,
   :station, to: :incident

  def initialize(bike = nil)
    @bike = bike unless bike.nil?
  end
  
  def bike
    @bike ||= Bike.new
  end

  def incident
    @incident ||= Incident.new(bike: bike)
  end

  def submit(params)
    bike.attributes = params.slice(:serial, :frame_make, :frame_model, :color, :description)
    incident.attributes = params.slice(:last_location, :police_incident_number, :officer_name, :station)
    incident.last_seen = Time.strptime(params[:last_seen], '%m/%d/%Y %H:%M')

    if valid?
      bike.save!
      incident.save!
      true
    else
      false
    end
  end

  def verify_bike_record
    unless bike.valid?
      bike.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
    end
  end

  def verify_incident_record
    unless incident.valid?
      incident.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
    end
  end
end

