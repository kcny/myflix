class Admin::VideosController < ApplicationController
  before_filter :require_user
  before_filter :require_admin

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You've successfully added '#{@video.title}' to your video collection."
      redirect_to new_admin_video_path
    else
      flash[:danger] = "Action denied. Please check the error messages."
      render :new
    end
  end

  private

 def video_params
  params.require(:video).permit(:title, :small_cover, :large_cover, :description, :category_id, :video_url)
end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Unauthorized action!"
      redirect_to home_path
    end
  end
end