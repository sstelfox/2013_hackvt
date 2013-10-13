
class BaseForm
  include ActiveModel::Model

  def persisted?
    false
  end

  def self.model_name
    class_name = self.class.to_s.gsub(/Form$/, '')
    ActiveModel::Name.new(self, nil, class_name)
  end
end

