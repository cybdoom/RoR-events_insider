# == Schema Information
#
# Table name: blogs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Blog < ActiveRecord::Base
  has_many :articles, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
end
