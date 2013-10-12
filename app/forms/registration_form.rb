
class RegistrationForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Registration")
  end

  delegate :email, :password, :password_confirmation, to: :user

  def user
    @user ||= User.new
  end

  def submit(params)
    user.attributes = params.slice(:email, :password, :password_confirmation)

    if user.valid? && valid?
      user.save!
    else
      false
    end
  end
end

