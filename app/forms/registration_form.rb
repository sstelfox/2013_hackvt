
class RegistrationForm < BaseForm
  include UserDelegation

  delegate :password, :password_confirmation, to: :user
  delegate :serial, :frame_make, :frame_model, :color, :description, to: :bike

  def bike
    @bike ||= Bike.new(user: user)
  end

  def submit(params)
    user.attributes = params.slice(:first_name, :last_name, :email, :phone,
                                   :password, :password_confirmation)

    bike.attributes = params.slice(:serial, :frame_make, :frame_model, :color,
                                   :description)

    if valid?
      user.save!
      bike.save!
      true
    else
      false
    end
  end

  def verify_bike_attributes
    unless bike.valid?
      bike.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
    end
  end
end

