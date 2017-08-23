class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types(:danger)

private

  def require_signin
    unless current_user
      flash[:alert] = "You must be logged in to access this."
      redirect_to signin_url
    end
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
