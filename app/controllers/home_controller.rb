class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  layout 'articles'

  def index
    @articles = Article.all.page(params[:page]).per 20
  end
end
