class UsersController < ApplicationController
  before_action :require_login, except: [ :new, :create, :confirm_email, :resend_confirmation ]

  before_action :set_user, only: [ :edit, :show, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.email_confirmation(@user, confirm_email_url(token: @user.confirmation_token)).deliver_now
      redirect_to sign_in_path, notice: "Please check your email to confirm your account."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by(confirmation_token: params[:token])
    if user && !user.confirmed?
      user.confirm!
      session[:user_id] = user.id
      redirect_to root_path, notice: "Your email has been confirmed."
    else
      redirect_to sign_in_path, alert: "Invalid or expired confirmation link."
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def resend_confirmation
    @user = User.find(params[:id])
    if !@user.confirmed?
      @user.generate_confirmation_token if @user.confirmation_token.blank?
      @user.save(validate: false)
      UserMailer.email_confirmation(@user, confirm_email_url(token: @user.confirmation_token)).deliver_now
      redirect_to sign_in_path, notice: "Verification email resent. Please check your inbox."
    else
      redirect_to root_path, alert: "Your email is already confirmed."
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to home_index_path, alert: "User not found."
  end
end
