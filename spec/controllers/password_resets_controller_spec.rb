require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if token is valid" do 
      anesu = Fabricate(:user)
      anesu.update_column(:token, '02468')
      get :show, id: '02468'
      expect(response).to render_template :show
    end
    it "redirects to expired token page if token is invalid" do 
      get :show, id: '02468'
      expect(response).to redirect_to expired_token_path
    end
  end
  
  describe "POST create" do 
  end
end
