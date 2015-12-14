class PagesController < ApplicationController
  layout 'pages'

  before_action :set_page, only: [:show, :redirect_to_show]

  def show
    raise ActionController::RoutingError.new('Page Not Found') unless @page.present?
  end

  def redirect_to_show
    redirect_to "/#{ params[:page_slug] }"
  end

  private

  def set_page
    @page = Page.find_by_slug params[:page_slug]
  end
end
