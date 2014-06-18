class Message
  include ActiveModel::AttributeMethods
  include ActiveModel::Serializers::JSON

  define_attribute_method :text

  attr_accessor :text

  def self.next_id
    @current_id = (@current_id || 0) + 1
  end

  def initialize(attributes)
    self.text = attributes['text']
  end

  def id
    @id ||= self.class.next_id
  end

  def attributes
    { 'text' => @text }
  end

  def save
    valid?
  end

  def valid?
    self.text.present?
  end

end