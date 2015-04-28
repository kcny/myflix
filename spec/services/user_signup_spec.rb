require 'spec_helper'

describe UserSignup do
  describe "#sign_up" do
    context "valid personal info and valid card" do
      context "successful user sign up" do
      let(:customer) { double(:customer, successful?: true) }

    before do
      StripeWrapper::Customer.should_receive(:create).and_return(customer)   
    end


    after do 
      ActionMailer::Base.deliveries.clear
    end
    it "creates the user" do
      UserSignup.new(Fabricate.build(:user)).sign_up("stripe_token", nil)
      expect(User.count).to eq(1)                                            
    end

    it "makes the user follow the inviter" do 
      anesu = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: anesu,
                       recipient_email: 'jabu@example.com')
      UserSignup.new(Fabricate.build(:user, email: 'jabu@example.com', password: 'password', full_name: 'Jabu Moyo')).sign_up("stripe_token", invitation_token)
      jabu = User.where(email: 'jabu@example.com').first
      expect(jabu.follows?(anesu)).to be_truthy                                   
    end

    it "makes the inviter follow the user" do 
      anesu = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: anesu,
                       recipient_email: 'jabu@example.com')
      UserSignup.new(Fabricate.build(:user, email: 'jabu@example.com', password: 'password', full_name: 'Jabu Moyo')).sign_up("stripe_token", invitation_token)
      jabu = User.where(email: 'jabu@example.com').first
      expect(anesu.follows?(jabu)).to be_truthy                                   
    end

    it "expires the invitation upon acceptance" do 
      anesu = Fabricate(:user)
      invitation = Fabricate(:invitation, inviter: anesu,
                       recipient_email: 'jabu@example.com')
      UserSignup.new(Fabricate.build(:user, email: 'jabu@example.com', password: 'password', full_name: 'Jabu Moyo')).sign_up("stripe_token", invitation_token)
      jabu = User.where(email: 'jabu@example.com').first
      expect(Invitation.first.token).to be_nil                                 
    end
    it "sends out email to user with valid inputs" do 
      UserSignup.new(Fabricate.build(:user, email: 'hoza@example.com')).sign_up("stripe_token", nil)
      expect(ActionMailer::Base.deliveries.last.to).to eq(['hoza@example.com'])
    end
    it "sends email with user's name and valid inputs" do
      UserSignup.new(Fabricate.build(:user, email: 'hoza@example.com', password: 'password', full_name: 'Hoza Zaka')).sign_up("stripe_token", nil) 
      email = ActionMailer::Base.deliveries.last
      expect(email.body).to include("Hoza Zaka")
    end 
  end
  context " with valid personal info and declided card" do
    it "does not create a new user record" do
      customer = double(:customer, successful?: false, error_message: "Your card was declined") 
      StripeWrapper::Customer.should_receive(:create).and_return(customer)
      UserSignup.new(Fabricate.build(:user)).sign_up('0246810', nil)
      expect(User.count).to eq(0)
    end
  end
  context "with invalid personal info" do 
    
    it "does not create the user" do
      UserSignup.new(User.new(email: "hoza@example.com")).sign_up('0246810', nil)  
      expect(User.count).to eq(0)
    end

    it "does not charge the card" do 
      StripeWrapper::Customer.should_not_receive(:create)
      UserSignup.new(User.new(email: "hoza@example.com")).sign_up('0246810', nil) 
    end

    it "does not send out email with invalid inputs" do 
        UserSignup.new(User.new(email: "hoza@example.com")).sign_up('0246810', nil) 
        expect(ActionMailer::Base.deliveries).to be_empty                                 
        end
      end
    end
  end
end

  
