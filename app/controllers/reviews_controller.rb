class ReviewsController < ApplicationController
before_filter :require_user

  def create
    @video = Video.find(params[:video_id])
    review = @video.reviews.create(review_params.merge!(user: current_user))
    if review.save
      flash[:notice] = "Your review has been saved."
      redirect_to @video
    else
      @reviews = @video.reviews.reload
      flash[:notice] = "Review was not created."
      render "videos/show"
    end
  end
end

def review_params
  params.require(:review).permit(:rating, :content)
end


