class PagesController < ApplicationController
  FREE_PAGE_SLUGS = [
    'contact',
    'getsubscription',
    'alreadysub',
    'about-johnny-monsarrat'
  ]

  layout 'pages'
  skip_before_filter :authenticate_user!
  before_action :check_authentication, only: [:show, :redirect_to_show]
  before_action :set_page, only: [:show, :redirect_to_show]

  def show
    raise ActionController::RoutingError.new('Page Not Found') unless @page.present?
  end

  def redirect_to_show
    redirect_to "/#{ params[:page_slug] }"
  end

  private

  def check_authentication
    authenticate_user! unless FREE_PAGE_SLUGS.include? params[:page_slug]
  end

  def set_page
    @page = Page.find_by_slug params[:page_slug]
  end
end
