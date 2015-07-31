# == Schema Information
#
# Table name: locations
#
#  id               :integer          not null, primary key
#  original_address :string
#  geocoded_address :string
#  country_code     :string(2)
#  region_code      :string
#  subregion_code   :string
#  city             :string
#  street           :string
#  street_number    :string
#  postcode         :string
#  latitude         :float
#  longitude        :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Location < ActiveRecord::Base
  geocoded_by :original_address do |location, results|
    if geo = results.first
      Rails.logger.debug "geo = #{format_data(geo)}"
    end
  end

  reverse_geocoded_by :latitude, :longitude

  validates :country_code, length: {is: 2}

  after_validation :geocode, if: :should_geocode?

  scope :useful, lambda { where('city IS NOT NULL AND LENGTH(city) > 0 OR
                                 region_code IS NOT NULL AND LENGTH(region_code) > 0') }

  def self.build_from_geoip(result)
    data = result.data
    location = self.new

    location.country_code = data['country_code']
    location.region_code = data['region_code']
    location.city = data['city']
    location.postcode = data['zipcode']
    if location.city?
      location.latitude = data['latitude']
      location.longitude = data['longitude']
    end

    location
  end

  def coordinates?
    latitude? && longitude?
  end

  def address
    if original_address?
      original_address
    elsif geocoded_address?
      geocoded_address
    else
      address_from_parts
    end
  end

  def address_from_parts
    parts = [street_number, street, city, region_name]
    parts.select(&:present?).join(', ')
  end

  def useful?
    region? || city? || coordinates?
  end

  def country
    Country.new(country_code)
  end

  def country?
    country_code?
  end

  def usa?
    country_code == 'US'
  end

  def region
    region? ? country.states[region_code] : nil
  end

  def region_name
    region? ? region['name'] : ''
  end

  def region?
    country_code? && region_code?
  end



  private

  def should_geocode?
    address.present? && address_changed?
  end

end
