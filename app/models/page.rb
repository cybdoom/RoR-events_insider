# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  DEFAULT_PAGES = [
    'Home',
    'About',
    'Subscribe',
    'Events',
    'News',
    'Contact'
  ]

  validates :title, uniqueness: true

  def self.custom_pages
    self.where('title NOT IN (?)', DEFAULT_PAGES)
  end
end
