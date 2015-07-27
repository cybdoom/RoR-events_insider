# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  venue_id             :integer
#  name                 :string           default(""), not null
#  description          :text
#  recurring            :boolean          default(FALSE), not null
#  starts_at            :datetime
#  ends_at              :datetime
#  price                :integer          default(0), not null
#  estimated_attendance :integer          default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_events_on_name      (name)
#  index_events_on_user_id   (user_id)
#  index_events_on_venue_id  (venue_id)
#

class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  has_many :images, as: :imageable, dependent: :destroy

  as_enum :price, {unknown: 0, free: 1, lt_10: 2, lt_25: 3, lt_75: 4, gt_75: 5},
                  source: :price
  as_enum :estimated_attendance, {unknown: 0, lt_25: 1, lt_100: 2, lt_500: 3, gt_500: 4},
                                 source: :estimated_attendance

  accepts_nested_attributes_for :images, allow_destroy: true

  delegate :location, to: :venue

  validates :venue, presence: true
  validates :name, presence: true, length: {minimum: 3}
  validates :starts_at, date: true
  validates :ends_at, date: {after: :starts_at, allow_blank: true}, if: :starts_at?

end
