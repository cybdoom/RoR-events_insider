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
#

class Article < ActiveRecord::Base
  belongs_to :blog
  has_many :images, as: :imageable, dependent: :destroy
end
