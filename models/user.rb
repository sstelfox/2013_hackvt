
require 'scrypt'

class User
  include DataMapper::Resource

  property :id,     Serial

  property :email,  String, length: 255
  property :crypt_pass, String, length: 96, accessor: :protected
  property :salt,       String, length: 32, accessor: :protected

  timestamps :at

  attr_accessor :password, :password_confirmation
  validates_confirmation_of :password, message: "Passwords don't match!"

  def password=(pass)
    @password = pass
    generate_salt
    self.crypt_pass = calc_hash(pass)
  end

  def calc_hash(pass)
    SCrypt::Engine.scrypt(pass, salt, SCrypt::Engine.autodetect_cost(salt), 32).unpack('H*').first
  end

  def generate_salt
    self.salt = SCrypt::Engine.generate_salt(max_time: 0.75)
  end
end

