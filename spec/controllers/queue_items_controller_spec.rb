require 'spec_helper'

describe QueueItemsController do 
  describe "GET index" do
    it "sets @queue_items to those of the logged in user" do
    anesu = Fabricate(:user)
    session[:user_id] = anesu.id 
    queue_item1 = Fabricate(:queue_item, user: anesu)
    queue_item2 = Fabricate(:queue_item, user: anesu)
    get :index
    expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
  end
    it "redirects the login page for unauthenticated users" do 
      get :index
      expect(response).to redirect_to login_path
    end
  end
end
