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
  end 
end