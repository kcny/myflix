# require 'spec_helper'

# feature 'User invites friend' do
#   scenario 'User successfully invites friend and invation is accepted' do 
#     anesu = Fabricate(:user)
#     login(anesu)

#     visit new_invitation_path
#     fill_in "Friend's Name", with: "Jabu Dube"
#     fill_in "Friend's Email Address", with: "jabu@example.com"
#     fill_in "Message", with: "Hello please join this site."
#     click_button "Sen Invitation"
#     logout

#     open_email "jabu@example.com"
#     current_email.clink_link "Accept this invitation"

#     fill_in "Password", with: "password"
#     fill_in "Full Name", with: "Jabu Dube"
#     click_button "Sign Up"

#     fill_in "Email Address", with: "jabu@example.com"
#     fill_in "Password", with: "password"
#     click_button "Log In"

#     click_link "People"
#     expect(page).to have_content anesu.full_name
#     logout

#     login(anesu)
#     click_link "People"
#     expect(page).to have_content(Jabu Dube)

#     clear_email
#   end 
# end
