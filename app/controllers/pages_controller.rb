class PagesController < ApplicationController
  layout 'pages'

  def show
    @page = Page.find_by_title params[:title]
  end
end
