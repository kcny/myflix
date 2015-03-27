require 'spec_helper'

feature 'User reset password' do
  scenario 'user successfully reset the password' do 
    anesu = Fabricate(:user, password:'old_password') 
    visit login_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: anesu.email 
    click_button "Send Email"

    open_email(anesu.email)
    current_email.click_link("Reset My Password")

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email Address", with: anesu.email
    fill_in "Password", with: "new_password"
    click_button "Login"

    expect(page).to have_content("Welcome, #{anesu.full_name}")
  end
end