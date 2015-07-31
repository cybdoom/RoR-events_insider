class Listing
  include Virtus.model
  include ActiveModel::Model
  include ActiveModel::Validations
  include Links

  attr_accessor :type, :name, :website, :location

  TYPES = ['event', 'venue', 'organization'].freeze

  attribute :type, String
  attribute :name, String
  attribute :website, String
  attribute :location, String

  validates :type, presence: true, inclusion: {in: self::TYPES, allow_blank: false}


  def self.translate_type(type)
    I18n.t("listing.type.#{type}")
  end

  def persisted?
    false
  end

  def path_for_redirect
    case type
    when 'event'
      h.new_event_path({event: {name: name}})
    end
  end

  def translate_type
    Listing.translate_type(type)
  end

end