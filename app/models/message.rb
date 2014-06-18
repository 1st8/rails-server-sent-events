class Message
  include ActiveModel::AttributeMethods
  include ActiveModel::Serializers::JSON

  define_attribute_method :text
  define_attribute_method :author

  attr_accessor :text
  attr_accessor :author

  def self.next_id
    @current_id = (@current_id || 0) + 1
  end

  def initialize(attributes)
    self.text = attributes['text']
    self.author = attributes[:author]
  end

  def id
    @id ||= self.class.next_id
  end

  def attributes
    { 'text' => @text, 'author' => @author }
  end

  def save
    valid?
  end

  def valid?
    self.text.present?
  end

end