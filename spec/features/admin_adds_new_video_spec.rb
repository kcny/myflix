require 'spec_helper'

feature "Admin add new video" do
  scenario "Admin successfully adds a new video" do
    admin = Fabricate(:admin)
    action = Fabricate(:category, name: "Action")
    login(admin)
    visit new_admin_video_path

    fill_in "Title", with: "Monk"
    select "Action", from: "Category"
    fill_in "Description", with: "Must watch this!"
    attach_file "Large cover", "spec/support/uploads/monk_large.jpg"
    attach_file "Small cover", "spec/support/uploads/monk.jpg"
    fill_in "Video URL", with: "http://www.example.com/my_video.mp4"
    click_button "Add Video"

    logout
    login

    visit video_path(Video.first)
    expect(page).to have_selector("img[src='/uploads/monk_large.jpg']")
    expect(page).to have_selector("a[href='http://www.example.com/my_video.mp4']")
  end
end