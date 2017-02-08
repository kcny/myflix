class SessionsController < ApplicationController

  def new
    redirect_to home_path if current_user
  end
  
  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      if user.active?
      session[:user_id] = user.id
      redirect_to home_path, notice: "You're now logged in!"
    else
      flash[:error] = "Your account has been deactived, please contact the help desk."
    redirect_to login_path
  end
    else
      flash[:error] = "Your email/password combination is invalid."
      redirect_to login_path
    end
  end

    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "You're now loged out."
  end
end