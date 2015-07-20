# == Schema Information
#
# Table name: locations
#
#  id                :integer          not null, primary key
#  location          :string           not null
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

  after_validation :geocode, if: :should_geocode?
  after_validation :reverse_geocode, if: :coordinates?

  def coordinates?
    latitude? && longitude?
  end

  private

  def should_geocode?
    location.present? && location_changed?
  end



end
