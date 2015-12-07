class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  skip_before_action :authenticate_user!, only: [:index, :show]
  layout 'articles'

  def index
    @articles = Article.all.page(params[:page]).per 20
  end

  def show
  end

  def search
    redirect_to root_path, flash: { warning: I18n.t('flash.warnings.we_moved') }
  end

  private

  def set_article
    @article = Article.find_by_slug(params[:slug])
  end

  def search_params
    params.permit(:year, :month, :old_title)
  end
end
