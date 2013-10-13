
class IncidentForm < BaseForm
  validate :verify_bike_record
  validate :verify_incident_record
  validate :verify_user_record

  delegate :serial, :frame_make, :frame_model, :color, :description, to: :bike
  delegate :last_seen, :last_location, :police_incident_number, :officer_name,
    :station, to: :incident
  delegate :first_name, :last_name, :phone, :email, :password,
    :password_confirmation, to: :user

  def initialize(bike = nil, user = nil)
    @bike = bike unless bike.nil?
    @user = user unless user.nil?
  end

  def bike
    @bike ||= Bike.new(user: user)
  end

  def incident
    @incident ||= Incident.new(bike: bike)
  end

  def user
    @user ||= User.new
  end

  def submit(params)
    bike.attributes = params.slice(:serial, :frame_make, :frame_model, :color, :description)
    incident.attributes = params.slice(:last_location, :police_incident_number, :officer_name, :station)

    if user.new_record?
      user.attributes = params.slice(:first_name, :last_name, :phone, :email, :password, :password_confirmation)
    end

    unless params[:last_seen] == ""
      incident.last_seen = Time.strptime(params[:last_seen], '%m/%d/%Y %H:%M')
    end

    if valid?
      user.save!
      bike.status = "stolen"
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

  def verify_user_record
    unless user.valid?
      user.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
    end
  end
end

