# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  location          :string
#  geocoded_location :string
#  country_code      :string(2)
#  region_code       :string
#  subregion_code    :string
#  city              :string
#  street            :string
#  street_number     :string
#  postcode          :string
#  latitude          :float
#  longitude         :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Location < ActiveRecord::Base
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude

  validates :country_code, length: {is: 2}

  after_validation :geocode, if: :should_geocode?
  after_validation :reverse_geocode, if: :coordinates?

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
    location.location = location.formatted_location

    location
  end

  def self.useful
    self.where('city IS NOT NULL AND LENGTH(city) > 0 OR
                region_code IS NOT NULL AND LENGTH(region_code) > 0')
  end

  def self.search(address)
    locations = self.useful
    locations.where('location LIKE %q% OR geocoded_location LIKE %q%', address)
  end

  def coordinates?
    latitude? && longitude?
  end

  def formatted_location
    location? ? location : address
  end

  def address
    components = [street_number, street, city, region_name].select(&:present?)
    address = components.join(', ')
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
    location.present? && location_changed?
  end

end
