
class PasswordResetForm < BaseForm
  attr_accessor :email, :password, :password_confirmation

  validate :email_exists
  validates_presence_of :email, :password
  validates_confirmation_of :password

  def email_exists
    unless email.blank? || User.exists?(email: email)
      errors.add(:email, "account doesn't exist")
    end
  end

  def submit(params)
    self.email = params[:email]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]

    if valid?
      user.password = password
      user.password_confirmation = password_confirmation
      user.save!

      true
    else
      false
    end
  end

  def user
    User.where(email: email).first
  end
end
