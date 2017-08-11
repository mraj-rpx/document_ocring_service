class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_signin

  helper_method :current_user

  def current_user
    session[:user]
  end

  private

  def require_signin
    redirect_to new_session_path if current_user.blank?
  end
end
