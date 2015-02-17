require 'spec_helper'

describe SessionsController do
  describe "GET new" do 
    it "renders the :new template for unauthenticated users" do 
      get :new
      expect(response).to render_template :new
    end
    it "redirects unauthenticated users to the home page" do 
      session[:user_id] = Fabricate(:user).id
      get :new 
      expect(response).to redirect_to home_path
    end 
  end

  describe "POST create" do 
    context "with valid credentials" do

    let(:anesu) { Fabricate :user }
    before do
        post :create, email: anesu.email, password: anesu.password 
    end 

      it "it logs user into the session" do
        expect(session[:user_id]).to eq(anesu.id)
      end 

      it "redirect_to to the home page" do 
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do 
        expect(flash[:notice]).not_to be_blank
      end
    end

    context "with invalid credential" do 

      before do  
        anesu = Fabricate(:user)
        post :create, email: anesu.email, password: anesu.password + 'zxaqcbgsdf'
      end

      it "does not allow user into the session" do 
        expect(session[:user_id]).to be_nil
      end
      it "redirects to the login page" do 
        expect(response).to redirect_to login_path
      end
      it "it gives an error message" do 
        expect(flash[:error]).not_to be_blank
      end
    end
  end

  describe "GET destroy" do 

    before do 
      session[:user_id] = Fabricate(:user).id 
      get :destroy
    end

    it "clears the session for the user" do 
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do 
      expect(response).to redirect_to root_path
    end

    it "set the notice" do
      expect(flash[:notice]).not_to be_blank
    end
  end
end