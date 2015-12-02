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

class Article < ActiveRecord::Base
  belongs_to :blog
  has_many :images, as: :imageable, dependent: :destroy

  after_save :generate_slug, if: lambda { self.slug.blank? }

  def to_param
    slug
  end

  private

  def generate_slug
    probably_slug = title.split(/\W+/)[0..2].join('-')
    probably_slug += "-#{self.id}" if Article.where(slug: probably_slug).any?
    probably_slug = URI.encode probably_slug
    self.slug = probably_slug
    self.save
  end
end
