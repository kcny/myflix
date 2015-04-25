class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => params[:stripeToken],
        :description => "Registration Fee for #{@user.full_name}"
      )
      if charge.successful?
        @user.save
        handle_invitation  
        AppMailer.send_welcome_email(@user).deliver
        flash[:success] = "Thanks for registering, please log in and enjoy!"  
        redirect_to login_path
      else
        flash[:error] = charge.error_message
        render :new
      end
    else
      flash[:error] = "Your infomation is invalid.  Please check the error messages and try again."
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.find_by(token: params[:token])
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end
end

private 

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end


  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.find_by(token: params[:invitation_token])
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end


 
  



