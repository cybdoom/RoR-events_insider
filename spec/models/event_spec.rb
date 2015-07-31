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

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
