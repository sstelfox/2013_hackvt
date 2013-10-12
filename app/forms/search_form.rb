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
    self.query = params[:query]

    if valid?
      search_attrs = %w{  serial frame_make frame_model color }
      search_string = search_attrs.map {|attr| "#{attr} like ?"}.join(" OR ")
      search_terms = []
      search_attrs.length.times { search_terms << "%#{query}%" }

      Bike.where(search_string, *search_terms)
    else
      false
    end
  end

end

