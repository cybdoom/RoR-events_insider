class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super
  rescue Exception => e
    redirect_to new_user_session_path, alert: "Failed to sign in. Exception: #{e.message}"
  end

  def destroy
    super
  rescue Exception => e
    redirect_to root_path, alert: "Failed to sign out. Exception: #{e.message}"
  end
end
