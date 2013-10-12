
class FoundForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Found")
  end

  validate :verify_bike_record

  delegate :serial, :frame_make, :frame_model, :color, :description, to: :bike

  def bike
    @bike ||= Bike.new
  end

  def submit(params)
    bike.attributes = params.slice(:serial, :frame_make, :frame_model, :color, :description)

    if valid?
      bike.status = "found"
      bike.save!
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
end

