require 'spec_helper'

describe User do 
it { should validate_presence_of(:email) }
it { should validate_presence_of(:password) }
it { should validate_presence_of(:full_name) }
it { should validate_uniqueness_of(:email) }

describe "queued_vidoe?" do 
  it "returns true when user queued video" do 
    user = Fabricate(:user)
    video = Fabricate(:video)
    Fabricate(:queue_item, user: user, video: video)
    user.queued_video?(video).should be_true
    end
  it "returns false if user has not queued video" do 
      user = Fabricate(:user)
      video = Fabricate(:video)
      user.queued_video?(video).should be_false
    end
  end
end
