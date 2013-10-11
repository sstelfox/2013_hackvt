
require 'scrypt'

class User
  include DataMapper::Resource

  property :id,     Serial

  property :email,  String, length: 255
  property :crypt_pass, String, length: 96, accessor: :protected
  property :salt,       String, length: 32, accessor: :protected

  timestamps :at
end
