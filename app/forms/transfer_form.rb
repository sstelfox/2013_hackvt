
class TransferForm < BaseForm
  include UserDelegation

  def initialize(bike)
    @bike = bike
  end

  def bike
    @bike
  end

  def submit(params)
    @user = User.where(email: params[:email]).first_or_create(params.slice(:first_name, :last_name))
    bike.user = @user

    if valid?
      user.save!
      bike.save!
      true
    else
      false
    end
  end
end

