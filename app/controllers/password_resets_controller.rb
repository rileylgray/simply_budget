class PasswordResetsController < ApplicationController
  before_action :require_login, except: [ :new, :create, :edit, :update ]
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_reset_password_token!
      # Send reset email
      UserMailer.password_reset(user, edit_password_reset_url(token: user.reset_password_token)).deliver_now
    end
    redirect_to sign_in_path, notice: "If your email exists in our system, you will receive a password reset link."
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token])
    unless @user&.reset_password_period_valid?
      redirect_to new_password_reset_path, alert: "Reset link has expired."
    end
  end

  def update
    @user = User.find_by(reset_password_token: params[:token])
    if @user&.reset_password_period_valid? && @user.update(password_params)
      @user.clear_reset_password_token!
      redirect_to sign_in_path, notice: "Password has been reset."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
