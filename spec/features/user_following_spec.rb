require 'spec_helper'

feature "User following" do 
  scenario "user follows and unfollows someone" do

    anesu = Fabricate(:user)
    category = Fabricate(:category)
    video = Fabricate(:video, category: category)
    Fabricate(:review, user: anesu, video: video)

    login
    click_on_video_on_home_page(video)

    click_link anesu.full_name
    click_link "Follow"
    expect(page).to have_content(anesu.full_name)

    unfollow(anesu)
    expect(page).not_to have_content(anesu.full_name)

  end

  def unfollow(user)
    find("a[data-method='delete']").click
  end
end


