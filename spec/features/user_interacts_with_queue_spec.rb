require 'spec_helper'

feature "User interacts with queue" do 
  scenario "user adds and reorders videos in queue" do

    action = Fabricate(:category)
    south_park = Fabricate(:video, title: "South Park", category: action)
    monk = Fabricate(:video, title: "Monk", category: action)
    family_guy = Fabricate(:video, title: "Family Guy", category: action)

    login

    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)
    
    visit video_path(monk)
    expect_link_not_to_be_seen("+ My Queue")
   
  
    add_video_to_queue(south_park)
    add_video_to_queue(family_guy)
    
    set_video_position(monk, 3)
    set_video_position(south_park, 1)
    set_video_position(family_guy, 2)
    update_queue
    
    expect_video_position(south_park, 1)
    expect_video_position(family_guy, 2)
    expect_video_position(monk, 3)
  end

  def update_queue
    click_button "Update Instant Queue"
  end
    
  def expect_video_to_be_in_queue(video)
    page.should have_content(video.title)
  end
  
  def expect_link_not_to_be_seen(link_text)
     page.should_not have_content(link_text)
    end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link "+ My Queue"
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
    fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
      expect(find(:xpath, "//tr[contains(.,'#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
    end
  end 
