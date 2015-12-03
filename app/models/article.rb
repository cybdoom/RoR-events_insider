# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  author     :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Article < ActiveRecord::Base
  has_many :images, as: :imageable, dependent: :destroy

  default_scope { order('created_at DESC') }

  after_save :generate_slug, if: lambda { self.slug.blank? }

  def to_param
    slug
  end

  def generate_slug
    parsed_title = Nokogiri::HTML(title).inner_text
    probably_slug = parsed_title.gsub(/( \'|\' |\A\'|\'$)/, ' ').strip.split(/\W+/)[0..2].join('-')
    probably_slug += "-#{self.id}" if Article.where(slug: probably_slug).count > 1
    probably_slug = URI.encode probably_slug
    self.slug = probably_slug
    self.save
  end
end
