# == Schema Information
#
# Table name: venues
#
#  id              :integer          not null, primary key
#  location_id     :integer          not null
#  user_id         :integer          not null
#  organization_id :integer
#  name            :string
#  description     :text
#  size            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_venues_on_location_id      (location_id)
#  index_venues_on_organization_id  (organization_id)
#  index_venues_on_user_id          (user_id)
#

class Venue < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
  belongs_to :organization
  has_many :events
  has_many :images, as: :imageable

  accepts_nested_attributes_for :events

  validates :name, presence: true, length: {minimum: 3}

end
