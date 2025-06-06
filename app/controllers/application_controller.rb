class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :set_current_user

  private

  def require_login
    unless logged_in? && current_user.confirmed?
      redirect_to sign_in_path, alert: "Please log in and verify your email to continue."
    end
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def current_user
    @current_user
  end

  def logged_in?
    !!current_user
  end

  helper_method :current_user, :logged_in?
end
