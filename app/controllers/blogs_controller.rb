class BlogsController < ApplicationController
  # skip_before_action :authenticate_user!
  before_action :set_blog, only: [:show]

  def index
    @blogs = Blog.all
  end

  def show
    @articles = @blog.articles.page params[:page]
  end

  private

  def set_blog
    @blog = Blog.find params[:id]
  end
end
