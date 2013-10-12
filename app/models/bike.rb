
require 'securerandom'

class Bike < ActiveRecord::Base
  validates :status, inclusion: { in: %w{ normal stolen found } }
  validates_uniqueness_of :hash_id

  belongs_to :user
  has_many :incidents

  before_create :generate_hash_id

  def generate_hash_id
    begin
      self.hash_id = SecureRandom.hex(16)
    end while !!self.class.exists?(hash_id: hash_id)
  end
end
