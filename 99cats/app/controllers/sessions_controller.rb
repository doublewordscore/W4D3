require 'byebug'

class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new, :create]
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      user_params[:user_name],
      user_params[:password]
    )
    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to cats_url
    else
      flash.now[:errors] = ["Unable to login"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
    redirect_to new_session_url
  end


  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
