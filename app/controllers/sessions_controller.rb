class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new]
  before_action :redirect_unless_logged_in, only: [:destroy]

  def new
  end

  def create
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Login successful!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password"
      render :new
    end
  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out!"
    redirect_to root_path
  end

  private

  def redirect_if_logged_in
    if session[:user_id]
      redirect_to root_path, alert: "You are already signed up and logged in!"
    end
  end

  def redirect_unless_logged_in
    unless session[:user_id]
      redirect_to login_path, alert: "You must be logged in to do that!"
    end
  end
end
