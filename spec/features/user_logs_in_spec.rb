require 'spec_helper'

feature "User logs in" do 
  scenario "with valid email and password" do
    anesu = Fabricate(:user) 
    login(anesu)
    page.should have_content anesu.full_name
  end
  scenario "with user deactivated" do
    anesu = Fabricate(:user, active: false) 
    login(anesu)
    expect(page).not_to have_content(anesu.full_name)
    expect(page).to have_content("Your account has been deactived, please contact the help desk.")
  end
end
