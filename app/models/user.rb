
class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w{ user shop cop } }

  validates_confirmation_of :password
  attr_accessor :password_confirmation

  has_many :bikes

  # TODO Email validation
  # TODO check user_type of for law_enforcement or bike_shop

  def self.authenticate(email, password)
    user = where(email: email).first

    return nil unless user
    return nil unless user.check_password(password)

    user
  end

  def check_password(pass)
    password == pass
  end

  def password
    SCrypt::Password.new(self[:password]) if self[:password]
  end

  def password=(pass)
    @password = pass
    self[:password] = SCrypt::Password.create(pass)
  end
end

