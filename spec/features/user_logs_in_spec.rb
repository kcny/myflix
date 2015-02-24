require 'spec_helper'

feature "User logs in" do 
  scenario "with valid email and password" do
    anesu = Fabricate(:user) 
    visit login_path
    fill_in "Email Address", with: anesu.email
    fill_in "Password", with: anesu.password
    click_button "Login"
    page.should have_content anesu.full_name
  end
end
