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

  describe "POST create" do 
    it "redirects to the my queue page" do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(response).to redirect_to my_queue_path
    end
    it "create a new queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.count).to eq(1)
    end
    it "creates queue item associated with video" do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates queue item associated with logged in user" do
      anesu = Fabricate(:user)
      session[:user_id] = anesu.id
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.first.user).to eq(anesu)
    end
    it "adds new videos to the end of the queue" do 
      anesu = Fabricate(:user)
      session[:user_id] = anesu.id
      mandela = Fabricate(:video)
      Fabricate(:queue_item, video: mandela, user: anesu)
      sarafina = Fabricate(:video)
      post :create, video_id: sarafina.id 
      sarafina_queue_item = QueueItem.where(video_id: sarafina.id, user_id: anesu.id).first
      expect(sarafina_queue_item.position).to eq(2)
    end
      it "adds new videos to the end of the queue" do 
      anesu = Fabricate(:user)
      session[:user_id] = anesu.id
      mandela = Fabricate(:video)
      Fabricate(:queue_item, video: mandela, user: anesu)
      sarafina = Fabricate(:video)
      post :create, video_id: mandela.id 
      sarafina_queue_item = QueueItem.where(video_id: mandela.id, user_id: anesu.id).first
      expect(anesu.queue_items.count).to eq(1)
    end
    it "redirects unauthenticated users to the login page" do
      post :create, video_id: 3
      expect(response).to redirect_to login_path
    end
  end

    describe "DELETE destroy" do 
      it "redirects user to the my queue page" do
        session[:user_id] = Fabricate(:user).id 
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id 
        expect(response).to redirect_to my_queue_path  
      end
      it "deletes the item in the queue" do
        anesu = Fabricate(:user) 
        session[:user_id] = anesu.id 
        queue_item = Fabricate(:queue_item, user: anesu)
        delete :destroy, id: queue_item.id 
        expect(QueueItem.count).to eq(0)  
      end
      it "it only deletes queue items that belong to the user" do
        anesu = Fabricate(:user)
        busi = Fabricate(:user) 
        session[:user_id] = anesu.id 
        queue_item = Fabricate(:queue_item, user: busi)
        delete :destroy, id: queue_item.id 
        expect(QueueItem.count).to eq(1)
      end   

      it "redirect unauthenticated users to the login page" do 
        delete :destroy, id: 3
        expect(response).to redirect_to login_path
      end
    end
  end
