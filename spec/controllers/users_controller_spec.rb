require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do 
      get :new 
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

describe "POST create" do 
  context "with valid input" do

    before do
      post :create, user: Fabricate.attributes_for(:user) 
    end

    it "creates the user" do
      expect(User.count).to eq(1)                                            
    end

    it "redirects to the login page" do
      expect(response).to redirect_to login_path
    end
  end

  context "with invalid input" do 

    before do  post :create, user: { password: "passpass", full_name: "Zebron Zimuto"} 
    end
    
    it "does not create the user" do 
        expect(User.count).to eq(0)
      end

    it "renders the :new template" do 
      expect(response).to render_template :new
    end

    it "sets the @user" do 
      expect(assigns(:user)).to be_instance_of(User)
    end                                   
  end

  context "email sending" do 

    after { ActionMailer::Base.deliveries.clear}
      
    it "sends out email to user with valid inputs" do 
      post :create, user: { email: "hoza@example.com", password: "password",
                                                    full_name: "Hoza Zaka"}
      expect(ActionMailer::Base.deliveries.last.to).to eq(['hoza@example.com'])
    end

    it "sends email with user's name and valid inputs" do 
     post :create, user: { email: "hoza@example.com", password: "password",
                                                    full_name: "Hoza Zaka"}
      email = ActionMailer::Base.deliveries.last
      expect(email.body).to include("Hoza Zaka")
    end 

    it "does not send out email with invalid inputs" do 
       post :create, user: { email: "hoza@example.com"}
      expect(ActionMailer::Base.deliveries).to be_empty
    end
  end
end

describe "GET show" do
    it_behaves_like "requires login" do 
      let(:action) {get :show, id: 1 }
    end

    it "sets @user" do 
      set_current_user
      zebron = Fabricate(:user)
      get :show, id: zebron.id 
      expect(assigns(:user)).to eq(zebron)
    end
  end

  describe "GET new_with_invitation_token" do
    it "renders the :new view timplate" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end  

    it "sets @user with recipient's email" do 
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it "redirects invalid tokens to the expired token page." do 
        invitation = Fabricate(:invitation)
        get :new_with_invitation_token, token: 'xyzabc123'
        expect(response).to redirect_to expired_token_path
      end
    end
  end




