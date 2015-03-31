require 'spec_helper'

describe User do 
it { should validate_presence_of(:email) }
it { should validate_presence_of(:password) }
it { should validate_presence_of(:full_name) }
it { should validate_uniqueness_of(:email) }
it { should have_many(:queue_items).order("position") }
it { should have_many(:reviews).order("created_at DESC") }

it_behaves_like "tokenable" do
  let(:object) { Fabricate(:user) } 
end

describe "queued_vidoe?" do 
  it "returns true when user queued video" do 
    user = Fabricate(:user)
    video = Fabricate(:video)
    Fabricate(:queue_item, user: user, video: video)
    user.queued_video?(video).should be_truthy
    end
  it "returns false if user has not queued video" do 
      user = Fabricate(:user)
      video = Fabricate(:video)
      user.queued_video?(video).should be_falsy
    end
  end

  describe "#follows?" do 
    it "returns true if the user has a following relationship with another user" do 
      anesu = Fabricate(:user)
      busi = Fabricate(:user)
      Fabricate(:relationship, leader: busi, follower: anesu)
      expect(anesu.follows?(busi)).to be_truthy
    end
    it "returns false if the user does not have a following relationship with another user" do 
      anesu = Fabricate(:user)
      busi = Fabricate(:user)
      Fabricate(:relationship, leader: anesu, follower: busi)
      expect(anesu.follows?(busi)).to be_falsy
    end
  end

  describe "#follow" do
    it "follows another user" do
      anesu = Fabricate(:user)
      busi = Fabricate(:user)
      anesu.follow(busi)
      expect(anesu.follows?(busi)).to be_truthy
      end
    it "does not follow self" do 
      busi = Fabricate(:user)
      busi.follow(busi)
      expect(busi.follows?(busi)).to be_falsy
    end
  end
end

