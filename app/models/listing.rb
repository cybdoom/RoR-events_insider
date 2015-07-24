class Listing
  include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Validations

  attr_accessor :type, :name, :website, :location

  TYPES = [:event, :venue, :organization].freeze

  validates :type, inclusion: {in: self::TYPES, allow_blank: false}

  # TODO: figure out to refactor common listings functionality

end