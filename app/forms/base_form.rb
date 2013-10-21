
class BaseForm
  include ActiveModel::Model

  def self.model_name
    class_name = self.name.gsub(/Form$/, '')
    ActiveModel::Name.new(self, nil, class_name)
  end

  def persisted?
    false
  end
end

