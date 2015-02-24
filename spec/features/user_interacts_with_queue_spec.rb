require 'spec_helper'

feature "User interacts with queue" do 
  scenario "user adds and reorders videos in queue" do

    action = Fabricate(:category)
    south_park = Fabricate(:video, title: "South Park", category: action)
    monk = Fabricate(:video, title: "Monk", category: action)
    family_guy = Fabricate(:video, title: "Family Guy", category: action)

    login

    find("a[href='/videos/#{south_park.id}']").click
    page.should have_content(south_park.title)

    click_link "+ My Queue"
    page.should have_content(south_park.title)

    visit video_path(south_park)
    page.should_not have_content "+ My Queue"

  end 
end