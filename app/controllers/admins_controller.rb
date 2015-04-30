class AdminsController < ApplicationController
  before_filter :require_admin

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Unauthorized action!"
      redirect_to home_path
    end
  end
end