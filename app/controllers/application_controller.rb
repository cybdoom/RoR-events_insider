require_dependency 'application_responder'
require_dependency 'ipaddr'

class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :authenticate_user!
  # before_filter :set_user_location, if: -> { user_signed_in? && !current_user.location_id? }

  respond_to :html

  def self.responder
    ApplicationResponder
  end

  def respond_modal_with(*args, &blk)
    options = args.extract_options!
    options[:responder] = ModalResponder
    respond_with(*args, options, &blk)
  end

  def guest_user?
    !current_user
  end

  def guest_user
    User.guest
  end

  protected

  def local_request?
    local_network = IPAddr.new('192.168.0.0/8')
    request.local? || local_network === request.remote_ip
  end

  def set_user_location
    if local_request? && ENV['GEOCODE_LOCAL_IPS']
      begin
        ip = Faraday.get('http://www.telize.com/ip').body
        ip.strip!
        locations = Geocoder.search(ip)
        location_data = locations.first
      rescue Faraday::ConnectionFailed
        location_data = request.location
      end
    else
      location_data = request.location
    end

    if location_data.present?
      location = Location.build_from_geoip(location_data)
      if location.save
        current_user.location = location
        current_user.save
      else
        Rails.logger.debug "errors when saving location: #{location.errors.inspect}"
      end
    end
  end

  def user_not_authorized(exception)
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

end
