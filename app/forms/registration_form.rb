
class RegistrationForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Registration")
  end

  delegate :first_name, :last_name, :email, :password, :password_confirmation, to: :user
  delegate :serial, :frame_make, :frame_model, :color, :description, to: :bike
  validate :verify_user_attributes

  def user
    @user ||= User.new
  end

  def bike
    @bike ||= Bike.new(user: user)
  end

  def submit(params)
    user.attributes = params.slice(:first_name, :last_name, :email, :password, :password_confirmation)
    bike.attributes = params.slice(:serial, :frame_make, :frame_model, :color, :description)

    if valid?
      user.save!
      bike.save!
      true
    else
      false
    end
  end

  def verify_user_attributes
    unless user.valid?
      user.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
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

