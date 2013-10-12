
class RegistrationForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Registration")
  end

  delegate :email, :password, :password_confirmation, to: :user
  validate :verify_user_attributes

  def user
    @user ||= User.new
  end

  def submit(params)
    user.attributes = params.slice(:email, :password, :password_confirmation)

    if valid?
      user.save!
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
end

