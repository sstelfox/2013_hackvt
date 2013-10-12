
class TransferForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Transfer")
  end

  def initialize(bike)
    @bike = bike
  end

  def user
    @user ||= User.new
  end

  validate :verify_user_record
  delegate :first_name, :last_name, :email, to: :user

  def submit(params)
    user.attributes = params.slice(:first_name, :last_name, :email)
    bike.user = user

    if valid?
      user.save!
      bike.save!
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

