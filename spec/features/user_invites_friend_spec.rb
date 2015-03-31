require 'spec_helper'

feature 'User invites friend' do
  scenario 'User successfully invites friend and invation is accepted' do 
    anesu = Fabricate(:user)
    login(anesu)

    invite_friend
    friend_accepts_invitation
    friend_logs_in
    
    friend_should_follow(anesu)
    inviter_should_follow_friend(anesu)

    clear_email
  end 

  def invite_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Jabu Dube"
    fill_in "Friend's Email Address", with: "jabu@example.com"
    fill_in "Message", with: "Hello please join this site."
    click_button "Send Invitation"
    logout
  end

  def friend_accepts_invitation
    open_email "jabu@example.com"
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Jabu Dube"
    click_button "Sign Up"
  end

  def friend_logs_in
    fill_in "Email Address", with: "jabu@example.com"
    fill_in "Password", with: "password"
    click_button "Login"
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.full_name
    logout
  end

  def inviter_should_follow_friend(inviter)
    login(inviter)
    click_link "People"
    expect(page).to have_content "Jabu Dube"
  end
end
