require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if token is valid" do 
      anesu = Fabricate(:user)
      anesu.update_column(:token, '02468')
      get :show, id: '02468'
      expect(response).to render_template :show
    end

    it "sets @token" do 
      anesu = Fabricate(:user)
      anesu.update_column(:token, '02468')
      get :show, id: '02468'
      expect(assigns(:token)).to eq('02468')
    end

    it "redirects to expired token page if token is invalid" do 
      get :show, id: '02468'
      expect(response).to redirect_to expired_token_path
    end
  end
  
  describe "POST create" do
    context "without valid token" do 
      it "redirects to the login page" do
        anesu = Fabricate(:user, password: 'old_password')
        anesu.update_column(:token, '02468')
        post :create, token: '02468', password: 'new_password'
        expect(response).to redirect_to login_path
      end
      it "updates the user's password" do 
        anesu = Fabricate(:user, password: 'old_password')
        anesu.update_column(:token, '02468')
        post :create, token: '02468', password: 'new_password'
        expect(anesu.reload.authenticate('new_password')).to be_truthy
      end
      it "set the flash success message" do
        anesu = Fabricate(:user, password: 'old_password')
        anesu.update_column(:token, '02468')
        post :create, token: '02468', password: 'new_password'
        expect(flash[:success]).to be_present 
      end
      it "regenerates the user token" do 
        anesu = Fabricate(:user, password: 'old_password')
        anesu.update_column(:token, '02468')
        post :create, token: '02468', password: 'new_password'
        expect(anesu.reload.token).not_to eq('02468')
      end
    end
    context "with invalid token" do 
      it "redirects to the expired token path" do
        post :create, token: '02468', password: 'foobar'
        expect(response).to redirect_to expired_token_path 
      end
    end
  end
end
