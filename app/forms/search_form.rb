
class SearchForm < BaseForm
  attr_accessor :query
  validates_presence_of :query

  def submit(params)
    self.query = params[:query]

    if valid?
      search_attrs = %w{ frame_make frame_model color }
      search_terms = []

      # Match any substring
      search_attrs.map! do |attr|
        search_terms << "%#{query}%"
        "#{attr} like ?"
      end
      search_string = search_attrs.join(" OR ")

      # Only exact matches for serial numbers
      search_string << " OR serial = ?"
      search_terms << query

      Bike.where(search_string, *search_terms)
    else
      false
    end
  end
end

