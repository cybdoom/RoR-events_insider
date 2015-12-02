# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  blog_id    :integer          not null
#  title      :string           not null
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
