require 'spec_helper'

describe UsersController, :vcr do
  before do 
    ActionMailer::Base.deliveries.clear
  end
  describe "GET new" do
    it "sets @user" do 
      get :new 
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

describe "POST create" do 

    it "redirects to the login page" do
      result = double(:sign_up_result, successful?: true)
      UserSignup.any_instance.should_receive(:sign_up).and_return(result)
      post :create, user: Fabricate.attributes_for(:user)
      expect(response).to redirect_to login_path
    end
  end

  context "failed user sign up" do
    it "renders the new template" do 
      result = double(:sign_up_result, successful?: false, error_message: "This is an error message")
      UserSignup.any_instance.should_receive(:sign_up).and_return(result)
      post :create, user: Fabricate.attributes_for(:user)
      expect(response).to render_template :new 
    end
    it "sets the flash error message" do 
      result = double(:sign_up_result, successful?: false, error_message: "This is an error message")
      UserSignup.any_instance.should_receive(:sign_up).and_return(result)
      post :create, user: Fabricate.attributes_for(:user), stripeToken: '0246810'
<<<<<<< HEAD
      expect(flash[:danger]).to be_present
    end
  end

  context "with invalid personal info" do 

    before do  
      post :create, user: { password: "passpass", full_name: "Zebron Zimuto"} 
    end
    
    it "does not create the user" do 
      expect(User.count).to eq(0)
      end

    it "renders the :new template" do 
      expect(response).to render_template :new
    end

     it "does not charge the card" do 
      StripeWrapper::Charge.should_not_receive(:create)
=======
      expect(flash[:danger]).to eq("This is an error message")
>>>>>>> master
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

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "redirects invalid tokens to the expired token page." do 
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: 'xyzabc123'
      expect(response).to redirect_to expired_token_path
      end
    end
  end
  




