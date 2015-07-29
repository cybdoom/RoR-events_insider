class SearchForm::Location < SearchForm::Base

  attribute :location, String

  validates :location, presence: true, length: {minimum: 4}

  def like_pattern
    "%#{location.downcase}%"
  end

  def search
    return Location.none if invalid?
    Location.useful
            .where('LOWER(location) LIKE ? OR LOWER(geocoded_location) LIKE ?', like_pattern)
    end
  end

end