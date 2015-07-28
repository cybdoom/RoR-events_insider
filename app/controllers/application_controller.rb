require_dependency 'application_responder'
require_dependency 'ipaddr'

class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :set_user_location

  respond_to :html

  def self.responder
    ApplicationResponder
  end

  def guest_user?
    !current_user
  end

  protected

  def local_request?
    local_network = IPAddr.new('192.168.0.0/8')
    request.local? || local_network === request.remote_ip
  end

  def set_user_location
    if local_request? && ENV['GEOCODE_LOCAL_IPS']
      ip = Faraday.get('http://www.telize.com/ip').body
      ip.strip!
      location = Geocoder.search(ip)
    else
      ip = request.remote_ip
      location = request.location
    end
    Rails.logger.debug "ip = #{ip.inspect}"
    Rails.logger.debug "location = #{location.inspect}"
  end

  def user_not_authorized(exception)
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

end
