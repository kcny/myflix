class Admin::VideosController < AdminsController
  before_filter :require_user
 
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
end