class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "You've successfully created your account!"
    else
      render :new
    end
  end
end

def user_params
  params.require(:user).permit(:email, :password, :full_name)
end