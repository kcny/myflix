class InvitationsController < ApplicationController
  before_filter :require_user
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new((invitation_params).merge!(inviter_id: current_user.id))
    if @invitation.save
      AppMailer.delay.send_invitation_email(@invitation)
      flash[:success] = "Your invitation has been successfully sent to #{@invitation.recipient_name}."
      redirect_to new_invitation_path
    else
      flash[:danger] = "Please check your entry."
      render :new
    end
  end

private

  def invitation_params
    params.require(:invitation).permit(:recipient_name, :recipient_email, :message)
  end
end
