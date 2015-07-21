class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :set_user_location

  def guest_user?
    !current_user
  end

  protected

  def set_user_location
    Rails.logger.debug "request.location = #{request.location}"
    # current_user.location = Location.build_from_geocoder_result(request.location)
  end

  def user_not_authorized(exception)
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

end
