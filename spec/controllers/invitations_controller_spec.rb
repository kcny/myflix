require 'spec_helper'

describe InvitationsController do 
  describe "GET new" do
    it "sets @invitation to a new invitation" do
      set_current_user 
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation  
    end

    it_behaves_like "requires login" do 
      let(:action) { get :new }
    end
  end
end
