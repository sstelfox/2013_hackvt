class Bike < ActiveRecord::Base
  validates :status, inclusion: { in: %w{ normal stolen found } }, default: "normal"

  belongs_to :user
  has_many :incidents
end
