require 'spec_helper'

describe ReviewsController do 
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    context "with authenticated users" do

      let(:current_user) { Fabricate(:user) }
      before do 
        session[:user_id] = current_user.id 
      end

      context "with valid input" do
        it "redirects to video show page" do 
          video = Fabricate(:video) 
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video
        end 
        it "creates a review" do
        video = Fabricate(:video) 
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1)
        end
        it "creates a review associated with video" do
          video = Fabricate(:video) 
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.video).to eq(video)
        end
        it "creates a review associated with signed in user" do 
          video = Fabricate(:video) 
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.user).to eq(current_user)
        end
      end
      context "with invalid input" do 
        it "does not create a review" do 
          video = Fabricate(:video) 
          post :create, review: {rating: 4}, video_id: video.id 
          expect(Review.count).to eq(0)
        end
        it "renders the videos /show template"
          # video = Fabricate(:video) 
          # post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          # expect(Review.first.video).to eq(video)
        # end
        it "sets the @videos"
          # video = Fabricate(:video) 
          # post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          # expect(Review.first.video).to eq(video)
        # end
        it "set @reviews"
          # video = Fabricate(:video) 
          # post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          # expect(Review.first.video).to eq(video)
        # end
      context "with unauthenticated users"
          # video = Fabricate(:video) 
          # post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          # expect(Review.first.video).to eq(video)
        end
      end
    end
  end
