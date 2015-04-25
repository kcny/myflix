require 'spec_helper'

describe UsersController, :vcr do
  describe "GET new" do
    it "sets @user" do 
      get :new 
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

describe "POST create" do 
    context "with valid personal info and card" do
      let(:charge) { double(:charge, successfull?: true) }

    before do
      post :create, user: Fabricate.attributes_for(:user)
      StripeWrapper::Charge.should_receive(:create).and_return(charge)
    end

    it "creates the user" do
      expect(User.count).to eq(1)                                            
    end

    it "redirects to the login page" do
      expect(response).to redirect_to login_path
    end

    it "makes the user follow the inviter" do 
      anesu = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: anesu,
                       recipient_email: 'jabu@example.com')
      post :create, user: {email: 'jabu@example.com', password: "password",
                                                  full_name: "Jabu Moyo"}, 
                                        invitation_token: invitation.token
      jabu = User.where(email: 'jabu@example.com').first
      expect(jabu.follows?(anesu)).to be_truthy                                   
    end
    it "makes the inviter follow the user" do 
      anesu = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: anesu,
                       recipient_email: 'jabu@example.com')
      post :create, user: {email: 'jabu@example.com', password: "password",
                                                  full_name: "Jabu Moyo"}, 
                                        invitation_token: invitation.token
      jabu = User.where(email: 'jabu@example.com').first
      expect(anesu.follows?(jabu)).to be_truthy                                   
    end
    it "expires the invitation upon acceptance" do 
      anesu = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: anesu,
                       recipient_email: 'jabu@example.com')
      post :create, user: {email: 'jabu@example.com', password: "password",
                                                  full_name: "Jabu Moyo"}, 
                                        invitation_token: invitation.token
      jabu = User.where(email: 'jabu@example.com').first
      expect(Invitation.first.token).to be_nil                                 
    end
  end

  context " with valid personal and declided card" do
    it "does not create a new user record" do
      charge = double(:charge, successfull?: false, error_message: "Your card was declined") 
      StripeWrapper::Charge.should_receive(:create).and_return(charge)
      post :create, user: Fabricate.attributes_for(:user), stripeToken: '0246810'
      expect(User.count).to eq(0)
    end
    it "renders the new template" do 
      charge = double(:charge, successfull?: false) 
      StripeWrapper::Charge.should_receive(:create).and_return(charge)
      post :create, user: Fabricate.attributes_for(:user), stripeToken: '0246810'
      expect(response).to render_template :new
    end
    it "sets the flash error message" do 
      charge = double(:charge, successfull?: false, error_message: "Your card was declined.") 
      StripeWrapper::Charge.should_receive(:create).and_return(charge)
      post :create, user: Fabricate.attributes_for(:user), stripeToken: '0246810'
      expect(flash[:error]).to be_present
    end
  end

  context "with invalid personal info" do 

    before do  post :create, user: { password: "passpass", full_name: "Zebron Zimuto"} 
    end
    
    it "does not create the user" do 
      expect(User.count).to eq(0)
      end

    it "renders the :new template" do 
      expect(response).to render_template :new
    end

     it "does not charge the card" do 
      StripeWrapper::Charge.should_not_receive(:create)
    end

    it "does not send out email with invalid inputs" do 
      post :create, user: { email: "hoza@example.com"}
      expect(ActionMailer::Base.deliveries).to be_empty
    end
    
    it "sets the @user" do 
      expect(assigns(:user)).to be_instance_of(User)
    end                                   
  end

  context "email sending" do
     let(:charge) { double(:charge, successfull?: true) }
    before do 
      StripeWrapper::Charge.should_receive(:create).and_return(charge)
    end 

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




