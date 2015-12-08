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
  COMMON_WORDS = %w(a an and as at by for from in of on or so that the to with)

  has_many :images, as: :imageable, dependent: :destroy

  default_scope { order('created_at DESC') }

  before_save :clear_slug, if: lambda { self.slug.present? && self.title_changed? }
  after_save :update_slug, if: lambda { self.slug.blank? }

  def to_param
    slug
  end

  def clear_slug
    self.slug = nil
  end

  def update_slug
    title_text = Nokogiri::HTML(title).inner_text
    new_slug = title_text.gsub /[^\s\w]/, ''
    words = new_slug.split /\W+/
    excess_words = COMMON_WORDS + ['Boston', 'MA']
    words.select! {|w| !(excess_words.include?(w.downcase) || /\A\d+\z/ =~ w) }
    new_slug = words[0..7].join '-'
    new_slug += "-#{self.id}" if Article.exists?(slug: new_slug)
    new_slug = URI.encode new_slug
    self.update_column :slug, new_slug
  end
end
