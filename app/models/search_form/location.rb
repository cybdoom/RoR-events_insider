class SearchForm::Location < SearchForm::Base
  attribute :address, String

  validates :address, presence: true, length: {minimum: 4}

  def search
    return Location.none if invalid?
    locations = Location.select("#{Location.table_name}.original_address")
                        .useful
                        .where('LOWER(original_address) LIKE ? OR
                                LOWER(geocoded_address) LIKE ?', like_pattern)

    external_locations = Geocoder.search(address)
  end

  def address
    super.downcase
  end

  private

  def like_pattern
    "%#{address}%"
  end

end