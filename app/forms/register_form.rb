
class RegisterForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  attr_accessor :email, :password, :password_confirmation

  validate :email_is_unique
  validates_presence_of :email, :password, :password_confirmation
  validates_confirmation_of :password

  def submit(params)
    self.email = params[:email]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]

    if valid?
      user = User.new(email: email)
      user.password = password
      user.save!
    else
      false
    end
  end

  def email_is_unique
    unless User.where(email: email)
      errors.add :email, "is already taken."
    end
  end
end

