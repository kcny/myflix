require 'spec_helper'

describe QueueItemsController do 
  describe "GET index" do
    it "sets @queue_items to those of the logged in user" do
    anesu = Fabricate(:user)
    set_current_user(anesu)
    queue_item1 = Fabricate(:queue_item, user: anesu)
    queue_item2 = Fabricate(:queue_item, user: anesu)
    get :index
    expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
  end

    it_behaves_like "requires login" do 
      let(:action) { get :index}
    end
  end

  describe "POST create" do 
    it "redirects to the my queue page" do 
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(response).to redirect_to my_queue_path
    end
    it "create a new queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.count).to eq(1)
    end
    it "creates queue item associated with video" do 
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates queue item associated with logged in user" do
      anesu = Fabricate(:user)
      set_current_user(anesu)
      video = Fabricate(:video)
      post :create, video_id: video.id 
      expect(QueueItem.first.user).to eq(anesu)
    end
    it "adds new videos to the end of the queue" do 
      anesu = Fabricate(:user)
      set_current_user(anesu)
      mandela = Fabricate(:video)
      Fabricate(:queue_item, video: mandela, user: anesu)
      sarafina = Fabricate(:video)
      post :create, video_id: sarafina.id 
      sarafina_queue_item = QueueItem.where(video_id: sarafina.id, user_id: anesu.id).first
      expect(sarafina_queue_item.position).to eq(2)
    end
      it "adds new videos to the end of the queue" do 
      anesu = Fabricate(:user)
      set_current_user(anesu)
      mandela = Fabricate(:video)
      Fabricate(:queue_item, video: mandela, user: anesu)
      sarafina = Fabricate(:video)
      post :create, video_id: mandela.id 
      sarafina_queue_item = QueueItem.where(video_id: mandela.id, user_id: anesu.id).first
      expect(anesu.queue_items.count).to eq(1)
    end
 
     it_behaves_like "requires login" do 
      let(:action) { post :create, video_id: 3 }
    end
  end

    describe "DELETE destroy" do 
      it "redirects user to the my queue page" do
        set_current_user 
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id 
        expect(response).to redirect_to my_queue_path  
      end
      it "deletes the item in the queue" do
        anesu = Fabricate(:user) 
        set_current_user(anesu) 
        queue_item = Fabricate(:queue_item, user: anesu)
        delete :destroy, id: queue_item.id 
        expect(QueueItem.count).to eq(0)  
      end

      it "normalizes the remaining queue_items" do
        anesu = Fabricate(:user) 
        set_current_user(anesu) 
        queue_item1 = Fabricate(:queue_item, user: anesu, position: 1)
        queue_item2 = Fabricate(:queue_item, user: anesu, position: 2)
        
        delete :destroy, id: queue_item1.id
        expect(QueueItem.first.position).to eq(1)
      end 

      it "it only deletes queue items that belong to the user" do
        anesu = Fabricate(:user)
        busi = Fabricate(:user) 
        set_current_user(anesu) 
        queue_item = Fabricate(:queue_item, user: busi)
        delete :destroy, id: queue_item.id 
        expect(QueueItem.count).to eq(1)
      end   

      it_behaves_like "requires login" do 
        let(:action) { delete :destroy, id: 3 }
      end
    end

    describe "POST update_queue_items" do

      it_behaves_like "requires login" do 
        let(:action) do 
          post :update_queue, queue_items: [{id: 2, position: 3},
                                                      {id: 4, position: 3}]
        end
      end 
      
      context "with valid input" do

        let(:anesu) { Fabricate(:user) }
        let(:video) { Fabricate(:video) }
        let(:queue_item1) { Fabricate(:queue_item, user: anesu, position: 1, video: video) }
        let(:queue_item2) { Fabricate(:queue_item, user: anesu, position: 2, video: video) }

        before { set_current_user(anesu) }


        it "redirect to my queue page" do 
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2},
                                         {id: queue_item2.id, position: 1}]
                              expect(response).to redirect_to my_queue_path
        end     

        it "reorders queue items" do 
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2},
                                           {id: queue_item2.id, position: 1}]
                                expect(anesu.queue_items).to eq([queue_item2, queue_item1])
          end

         it "normalizes postions numbers" do 
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3},
                                           {id: queue_item2.id, position: 2}]
                                expect(anesu.queue_items.map(&:position)).to eq([1, 2])
          end
        end
        
      context "with invalid input" do 

        let(:anesu) { Fabricate(:user) }
        let(:video) { Fabricate(:video) }
        let(:queue_item1) { Fabricate(:queue_item, user: anesu, position: 1, video: video) }
        let(:queue_item2) { Fabricate(:queue_item, user: anesu, position: 2, video: video) }

        before { set_current_user(anesu) }
        

        it "redirects to the my queue page" do 
          post :update_queue, queue_items: [{id: queue_item1.id, position: 4.5},
                                           {id: queue_item2.id, position: 2}]
                                expect(response).to redirect_to my_queue_path
          end

        it "sets a flash error message" do 
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3.5},
                                           {id: queue_item2.id, position: 2}]
                                            expect(flash[:error]).to be_present
          end
        it "does not change the queue items" do 
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3},
                                           {id: queue_item2.id, position: 2.5}]
                                    expect(queue_item1.reload.position).to eq(1)
            end
          end 

      context "with queue items that do not belong to current user" do 
          it "does not change queue items" do 
            anesu = Fabricate(:user) 
            set_current_user(anesu) 
            busi = Fabricate(:user)
            video = Fabricate(:video) 
            queue_item1 = Fabricate(:queue_item, user: anesu, position: 1, video: video)
            queue_item2 = Fabricate(:queue_item, user: busi, position: 2, video: video)
            post :update_queue, queue_items: [{id: queue_item1.id, position: 3},
                                             {id: queue_item2.id, position: 2}]
                                      expect(queue_item1.reload.position).to eq(1)
          end
        end
      end
    end



  
