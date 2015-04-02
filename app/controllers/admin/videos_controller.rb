class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  private

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Unauthorized action!"
      redirect_to home_path
    end
  end
end