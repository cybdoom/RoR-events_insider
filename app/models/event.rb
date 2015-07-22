# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  venue_id           :integer
#  name               :string           not null
#  image              :string
#  image_content_type :string
#  image_file_size    :integer
#  image_width        :integer
#  image_height       :integer
#  recurring          :boolean          not null
#  starts_at          :datetime
#  ends_at            :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_events_on_name      (name)
#  index_events_on_user_id   (user_id)
#  index_events_on_venue_id  (venue_id)
#

class Event < ActiveRecord::Base



end
