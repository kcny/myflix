require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    it "sets @relationships to the current user's following relationships" do 
      anesu = Fabricate(:user)
      set_current_user(anesu)
      busi = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: anesu, leader: busi)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
    
    it_behaves_like "requires login" do
      let(:action) { get :index } 
    end
  end
  
  describe "DELETE destroy" do
    it_behaves_like "requires login" do
      let(:action) { delete :destroy, id: 2 } 
    end

    it "redirects to the people page" do
      anesu = Fabricate(:user)
      set_current_user(anesu)
      busi = Fabricate(:user)
      set_current_user
      relationship = Fabricate(:relationship, follower: anesu, leader: busi)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end 

    it "deletes relationship if current user is follower" do 
      anesu = Fabricate(:user)
      set_current_user(anesu)
      busi = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: anesu, leader: busi)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end

    it "does not delete relationship if current user is not follower" do
      anesu = Fabricate(:user)
      set_current_user(anesu)
      busi = Fabricate(:user)
      chipo = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: chipo, leader: busi)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
  end

  describe "POST create" do 
    it_behaves_like "requires login" do
      let(:action) { post :create, leader_id: 6 } 
    end

    it "redirects to the people page" do 
      anesu = Fabricate(:user)
      busi = Fabricate(:user)
      set_current_user(anesu)
      post :create, leader_id: busi.id 
      expect(response).to redirect_to people_path
    end

    it "creates a relatinship where current user follows leader" do
      anesu = Fabricate(:user)
      busi = Fabricate(:user)
      set_current_user(anesu)
      post :create, leader_id: busi.id 
      expect(anesu.following_relationships.first.leader).to eq(busi) 
    end

    it "does not create a relationship with the same leader more than once" do
      anesu = Fabricate(:user)
      busi = Fabricate(:user)
      set_current_user(anesu)
      Fabricate(:relationship, follower: anesu, leader: busi)
      post :create, leader_id: busi.id 
      expect(Relationship.count).to eq(1)
    end
    it "does not allow the following of onseself" do 
      busi = Fabricate(:user)
      set_current_user(busi)
      post :create, leader_id: busi.id 
      expect(Relationship.count).to eq(0)
    end
  end
end
