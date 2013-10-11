
require 'scrypt'

class User
  include DataMapper::Resource

  property :id,     Serial

  property :email,  String, length: 255
  property :crypt_pass, String, length: 96, accessor: :protected
  property :salt,       String, length: 32, accessor: :protected

  timestamps :at

  validates_presence_of :username

  attr_accessor :password, :password_confirmation
  validate_presence_of :password, if: lambda { |u| !(u.has_password?) }, message: "Please provide a password for your account."
  validates_confirmation_of :password, message: "Passwords don't match!"

  def self.authenticate(user, pass)
    user = first(username: user)

    return nil if user.nil?
    return nil unless user.check_password(pass)

    user
  end

  def check_password(pass)
    (crypt_hash == calc_hash(pass))
  end
  
  def has_password?
    (!!crypt_pass && !!salt)
  end

  def password=(pass)
    @password = pass
    generate_salt
    self.crypt_pass = calc_hash(pass)
  end

  protected

  def calc_hash(pass)
    SCrypt::Engine.scrypt(pass, salt, SCrypt::Engine.autodetect_cost(salt), 32).unpack('H*').first
  end

  def generate_salt
    self.salt = SCrypt::Engine.generate_salt(max_time: 0.75)
  end
end

