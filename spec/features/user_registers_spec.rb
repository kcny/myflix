require 'spec_helper'

feature 'User registers',{ js: true, vcr: true } do
  background do   
    visit register_path
  end

  scenario 'with valid user info and card' do
    fill_in_valid_user_info
    fill_in_valid_valid_card
    click_button "Sign Up"  

    expect(page).to have_content("Thanks for registering, please log in and enjoy!")
  end
  scenario 'with valid user info and invalid card' do 
  fill_in_valid_user_info
  fill_in_invalid_card
  click_button "Sign Up"
  expect(page).to have_content("This card number looks invalid")          
  end 
  scenario 'with valid user info and declined card' do
  fill_in_declined_card
  click_button "Sign Up"
  expect(page).to have_content("Your card was declined.")
  end 
  scenario 'with invalid user info and valid card' do
  fill_in_invalid_user_info
  fill_in_valid_card
  click_button "Sign Up"
  expect(page).to have_content("You infomation is invalide.  Please check the error messages and try again.") 
  end 
  scenario 'with valid user info and invalid card' 
  scenario 'with invalid user info and invalid card'

  def fill_in_valid_user_info
    fill_in "Email Address", with: "jabu@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Jabu Dube"
   end
  def fill_in_valid_card
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "4 - April", from: "date_month"
    select "2019", from: "date_year"
    end 
   def fill_in_invalid_card
    fill_in "Credit Card Number", with: "123"
    fill_in "Security Code", with: "123"
    select "4 - April", from: "date_month"
    select "2019", from: "date_year"
   end
   def fill_in_declined_card
    fill_in "Credit Card Number", with: "4000000000000002"
    fill_in "Security Code", with: "123"
    select "4 - April", from: "date_month"
    select "2019", from: "date_year"    
    end 

    def fill_in_invalid_user_info
      fill_in "Email Address", with: "jabu@example.com"
     end 
  end
      
