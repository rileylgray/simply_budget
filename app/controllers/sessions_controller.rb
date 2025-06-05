class SessionsController < ApplicationController
  layout "sessions"
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      if @user.confirmed?
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Successfully signed in."
      else
        flash.now[:alert] = "Please confirm your email before signing in."
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path, notice: "Successfully signed out."
  end
end
