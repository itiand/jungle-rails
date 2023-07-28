class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new]
  before_action :redirect_unless_logged_in, only: [:destroy]

  def new
    puts "HERE IN SESSIONS NEW"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      puts "LOGIN SUCCESSFUL!"
      redirect_to root_path
    else
      puts "WRONG PASSWORD"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    puts "LOGGED OUT!"
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
