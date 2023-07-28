class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Sign up successful. Welcome!"
      redirect_to root_path
    else
      flash.now[:alert] = @user.errors.full_messages.join("| ")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def redirect_if_logged_in
    if session[:user_id]
      redirect_to root_path, notice: "You are already signed up and logged in!"
    end
  end
end


