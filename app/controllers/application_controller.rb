class ApplicationController < ActionController::Base
  skip_forgery_protection
  before_action :set_current_user
  before_action :valid_session

  private

  def valid_session
    # Check if user is in session controller
    return if controller_name == "sessions" || (controller_name == "users" && action_name.in?(%w[new create]))

    if session[:user_id].nil? || !User.exists?(session[:user_id])
      session[:user_id] = nil
      redirect_to sign_in_path, alert: "Please log in to continue."
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
