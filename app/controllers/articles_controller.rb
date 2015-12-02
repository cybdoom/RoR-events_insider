class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  skip_before_action :authenticate_user!, only: [:index, :show]
  layout 'articles'

  def index
    @articles = Article.all.page(params[:page]).per 20
  end

  def show
  end

  private

  def set_article
    @article = Article.find_by_slug(params[:slug])
  end
end
