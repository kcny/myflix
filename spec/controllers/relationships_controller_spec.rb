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
end