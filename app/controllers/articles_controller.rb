class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  layout 'articles'

  def index
    @articles = Article.all.page(params[:page]).per 20
  end

  def show
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
end
