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
#  old_slug   :string
#

class Article < ActiveRecord::Base
  COMMON_WORDS = %w(a an and as at by for from in of on or so that the to with)

  has_many :images, as: :imageable, dependent: :destroy

  default_scope { order('created_at DESC') }

  before_save :clear_slug, if: lambda { self.slug.present? && self.title_changed? }
  after_save :update_slug, if: lambda { self.slug.blank? }

  def self.find_by_old_url params
    old_slug = params[:old_slug]
    @result = Article.where(old_slug: old_slug).first
    return @result if @result.present?

    key_words = old_slug.split('-').map(&:downcase) - COMMON_WORDS
    articles = Article.where('extract(year from created_at) = ? and extract(month from created_at) = ?', params[:year].to_i, params[:month].to_i)
    max_matches = 0
    @result = nil
    articles.find_each do |article|
      words = article.slug.split('-').map &:downcase
      matches = key_words.count - (key_words - words).count
      if matches > max_matches
        max_matches = matches
        @result = article
      end
    end
    @result.update_attribute :old_slug, old_slug if @result.present?
    @result
  end

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
