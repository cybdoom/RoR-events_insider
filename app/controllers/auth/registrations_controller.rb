class Auth::RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, only: [:update]

  respond_to :html, :js

  def create
    super do |user|
      # custom user saving logic goes here
    end
  end



  protected

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:account_update) do |params|
      params.permit(:name, :email, :password, :password_confirmation)
      # params sanitizing logic goes here
    end
  end

end
