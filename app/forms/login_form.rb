
class LoginForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Login")
  end

  attr_accessor :email, :password
  validate :verify_user_credentials

  def user
    @user ||= User.new
  end

  def submit(params)
    self.email = params[:email]
    self.password = params[:password]

    if valid?
      true
    else
      false
    end
  end

  def verify_user_credentials
    unless @user = User.authenticate(email, password)
      errors.add(:email, "Invalid email or password.")
    end
  end
end
