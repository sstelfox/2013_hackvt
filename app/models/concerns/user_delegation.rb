
module UserDelegation
  extend ActiveSupport::Concern

  included do
    delegate :first_name, :last_name, :email, :phone, to: :user
    validate :verify_user_attributes
  end

  def user
    @user ||= User.new
  end

  def verify_user_attributes
    unless user.valid?
      user.errors.messages.each do |attr, msgs|
        msgs.each { |m| errors.add(attr, m) }
      end
    end
  end
end

