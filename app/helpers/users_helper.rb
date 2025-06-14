module UsersHelper
  def user_profile_link(user)
    link_to user.name, user_path(user)
  end

  def user_signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
