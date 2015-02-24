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

    visit home_path
    find("a[href='/videos/#{monk.id}']").click
    click_link "+ My Queue"

    visit home_path
    find("a[href='/videos/#{family_guy.id}']").click
    click_link "+ My Queue"

    fill_in "video_#{south_park.id}", with: 3
    fill_in "video_#{monk.id}", with: 1
    fill_in "video_#{family_guy.id}", with: 2

    click_button "Update Instant Queue"

    expect(find("video_#{monk.id}").value).to eq("1")
    expect(find("video_#{family_guy.id}").value).to eq("2")
    expect(find("video_#{south_park.id}").value).to eq("3")

  end 
end