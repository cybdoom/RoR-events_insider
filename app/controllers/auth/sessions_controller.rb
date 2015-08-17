class Auth::SessionsController < Devise::SessionsController
  after_action :set_csrf_headers, only: [:create, :destroy]

  # protect_from_forgery except: :new

  respond_to :html, :js

  def create
    super do |user|
      # custom login logic
    end
  end

  def destroy
    # custom cleanup logic before log out
    super
    # custom cleanup logic after logout
  end

  def sign_in_and_redirect(resource_or_scope, *args)
    options  = args.extract_options!
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    user = args.last || resource_or_scope

    respond_to do |format|
      format.html { super }
      format.js do
        sign_in(scope, resource) if warden.user(scope) != user
        redirect_url = stored_location_for(scope)
        Rails.logger.debug "redirect_url = #{redirect_url.inspect}"
        # flash.delete(:notice)
        if redirect_url.present?
          redirect_url = "#{redirect_url}.js" if redirect_url[-3..-1] != '.js'
          redirect_url += redirect_url.match(/\?/) ? '&' : '?'
          redirect_url += "after_authentication=true"
          Rails.logger.debug "actual redirect_url = #{redirect_url.inspect}"
          redirect_to redirect_url
        end
      end

    end
  end

  protected

  def set_csrf_headers
    if request.xhr?
      response.headers['X-CSRF-Token'] = "#{form_authenticity_token}"
      response.headers['X-CSRF-Param'] = "#{request_forgery_protection_token}"
    end
  end

end
