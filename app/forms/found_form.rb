
class FoundForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Found")
  end

  validate :verify_bike_record
  validate :verify_contact_record

  delegate :serial, :frame_make, :frame_model, to: :bike

  def bike
    @bike ||= Bike.new
  end

  def contact
    @contact ||= Contact.new(bike: contact)
  end

  def submit(params)
    bike.attributes = params.slice(:serial, :frame_make, :frame_model)

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

