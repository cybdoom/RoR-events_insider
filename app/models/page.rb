# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
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

  after_create :generate_slug

  def to_param
    self.slug
  end

  validates :title, uniqueness: true

  def self.custom_pages
    self.where('title NOT IN (?)', DEFAULT_PAGES)
  end

  private

  def generate_slug
    self.update_attribute :slug, self.title
  end
end
