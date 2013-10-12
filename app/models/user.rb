
class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  validates_confirmation_of :password
  attr_accessor :password_confirmation

  has_many :bikes

  # TODO add hashing

  def self.authenticate(email, password)
    where(email: email, password: password).first
  end
end

