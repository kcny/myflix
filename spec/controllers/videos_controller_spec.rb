require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video for authenticated users" do
    session[:user_id] = Fabricate(:user).id  
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id  
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
    it "redirects unauthenticated users to the login page" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to login_path
    end
  end

  describe "POST search" do 
    it "sets results for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      mandela = Fabricate(:video, title: 'Mandela')
      post :search, search_term: 'dela'
      expect(assigns(:results)).to eq([mandela])
   end   
    it "redirects to login page for unauthenticated users" do
      mandela = Fabricate(:video, title: 'Mandela')
      post :search, search_term: 'dela'
      expect(response).to redirect_to login_path
    end 
  end
end
