class ReviewsController < ApplicationController

  def create
    video = Video.find(params[:video_id])
    review = video.reviews.create(review_params.merge!(user: current_user))
    redirect_to video_path(video)
  end
end

def review_params
  params.require(:review).permit(:rating, :comment)
end


