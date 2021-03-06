shared_examples "requires login" do 
  it "redirects to the login page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to login_path
  end 
end

shared_examples "requires admin" do
  it "redirects to the home page" do
    session[:user_id] = Fabricate(:user)
    action
    expect(response).to redirect_to home_path 
  end 
end

shared_examples "tokenable" do
  it "generates a random token when a user is created" do
    expect(object.token).to be_present  
  end
end


