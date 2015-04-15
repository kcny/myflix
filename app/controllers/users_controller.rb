class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # if @user.valid?
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      token = params[:stripeToken]
      begin
        charge = Stripe::Charge.create(
          :amount => 999,
          :currency => "usd",
          :source => token,
          :description => "My Flix Registration Fee"
        )
      rescue Stripe::CardError => e
        flash[:danger] = e.message
      end
      @user.save
      handle_invitation
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

private 

def handle_invitation
  if params[:invitation_token].present?
    invitation = Invitation.where(token: params[:invitation_token]).first
    @user.follow(invitation.inviter)
    invitation.inviter.follow(@user)
    invitation.update_column(:token, nil)
  end
end

def user_params
  params.require(:user).permit(:email, :password, :full_name)
end

