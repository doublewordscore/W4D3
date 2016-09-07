class UsersController < ApplicationController

  before_action :redirect_if_logged_in
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
      redirect_to cats_url
    else
      flash[:errors] = ["User wasn't created!"]
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
