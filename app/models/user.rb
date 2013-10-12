
require 'scrypt'

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  def self.authenticate(email, password)
    user = first(email: email)

    return nil if user.nil?
    return nil unless user.check_password(pass)

    user
  end

  # Check the user's password against the stored one and return whether or not
  # the password provided matches the stored salt and hash.
  #
  # @param [String] pass
  # @return [Boolean]
  def check_password(pass)
    (crypt_pass == calc_hash(pass))
  end

  # Returns whether or not there is already a password on the user's instance,
  # used as part of a conditional validator.
  #
  # @api public
  # @return [Boolean]
  def has_password?
    (!!crypt_pass && !!salt)
  end

  # Override password setting, this is a virtual attribute and never gets saved
  # directly. This however generates a new salt and caculates a new scrypt hash.
  #
  # @api public
  # @param [String] pass
  # @return [String]
  def password=(pass)
    generate_salt
    self.crypt_pass = calc_hash(pass)
  end

  protected

  # Calculate a hash based on the stored user's salt and the provided password.
  #
  # @param [String] pass
  # @return [String]
  def calc_hash(pass)
    SCrypt::Engine.scrypt( pass, self[:salt], SCrypt::Engine.autodetect_cost(self[:salt]), 32).unpack('H*').first
  end

  # Set and generate a salt for use with SCrypt. The strength of any new
  # passwords can be adjusted by changing the parameters to the salt generator.
  #
  # @return [String]
  def generate_salt
    self[:salt] = SCrypt::Engine.generate_salt(max_time: 0.75)
  end
end

