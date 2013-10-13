
class FoundForm < BaseForm
  validate :verify_bike_record
  validate :verify_contact_record

  delegate :serial, :frame_make, :frame_model, :description, to: :bike
  delegate :phone, :email, to: :contact

  def initialize(bike_hash)
    if bike_hash
      (@bike = Bike.find_by_hash_id(bike_hash)) && @found = true
    end
  end

  def bike
    @bike ||= Bike.new
  end

  def contact
    @contact ||= Contact.new(bike: bike)
  end

  def found?
    @found ||= false
  end

  def submit(params)
    bike.attributes = params.slice(:serial, :frame_make, :frame_model, :description)
    contact.attributes = params.slice(:phone, :email)

    if valid?
      # Maybe search in our DB for the serial number here?
      bike.status = "found"
      bike.save!
      contact.save!
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

  def verify_contact_record
    unless contact.valid?
      contact.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
    end
  end
end

