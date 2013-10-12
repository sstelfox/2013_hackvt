
class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  validates_confirmation_of :password
  attr_accessor :password_confirmation

  has_many :bikes

  # TODO Email validation
  # TODO add password hashing
  #
  # TODO check user_type of for law_enforcement or bike_shop

  def self.authenticate(email, password)
    where(email: email, password: password).first
  end
end

