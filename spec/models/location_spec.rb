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

require 'rails_helper'

RSpec.describe Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
