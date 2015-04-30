require 'spec_helper'
feature 'Admin sees payments' do
  background do
    anesu = Fabricate(:user, full_name: "Anesu Dube", email: "anesu@example.com") 
    Fabricate(:payment, amount: 999, user: anesu)
  end
  scenario 'admin is able to see payments' do
    login(Fabricate(:admin))
    visit admin_payments_path
    expect(page).to have_content("$9.99")
    expect(page).to have_content("Anesu Dube")
    expect(page).to have_content("anesu@example.com")
  end
  scenario 'admin is unable to see payments' do
    login(Fabricate(:user))
    visit admin_payments_path
    expect(page).not_to have_content("$9.99")
    expect(page).not_to have_content("Anesu Dube")
    expect(page).to have_content("Unauthorized action!") 
  end
    
  end
