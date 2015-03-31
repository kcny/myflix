class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if params[:invitation_token].present?
        invitation = Invitation.where(token: params[:invitation_token]).first
        @user.follow(invitation.inviter)
      end
      AppMailer.send_welcome_email(@user).deliver
      redirect_to login_path, notice: "You've successfully created your account!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end
end

def user_params
  params.require(:user).permit(:email, :password, :full_name)
end