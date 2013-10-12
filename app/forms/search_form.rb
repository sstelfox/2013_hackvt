class SearchForm
  include ActiveModel::Model

  attr_accessor :query

  validates_presence_of :query

  def persisted?
    false
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Search")
  end

  def submit(params)
    self.serial = params[:serial]

    if valid?
      Bike.where(serial: serial)
    else
      false
    end
  end

end

