
class PasswordResetForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "PasswordReset")
  end

  validate :verify_user_record
  delegate :email, :password, :password_confirmation, to: :user

  def user
    @user ||= User.new
  end

  def submit(params)
    unless @user = User.where(email: params[:email]).first
      errors.add(:email, "Email doesn't exist")
    else
      user.atttributes = params.slice(:password, :password_confirmation)
    end

    if valid?
      user.save!
      true
    else
      false
    end
  end

  def verify_user_record
    unless user.valid?
      user.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
    end
  end
end
