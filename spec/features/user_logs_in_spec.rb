require 'spec_helper'

feature "User logs in" do 
  scenario "with valid email and password" do
    anesu = Fabricate(:user) 
    login(anesu)
    page.should have_content anesu.full_name
  end
end
