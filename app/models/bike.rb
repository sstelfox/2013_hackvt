class Bike < ActiveRecord::Base
  validates :status, inclusion: { in: %w{ normal stolen found } }
  belongs_to :user
  has_many :incidents
end
