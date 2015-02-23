require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }
  
 
  describe "#video_title" do 
    it "returns the associated video's title" do 
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end
  end

  describe "#rating" do
    it "returns a review if a review is available" do 
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video, rating: 3)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(3)
    end
    it "returns nil in the absence of a review" do 
      video = Fabricate(:video)
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: user, video: video)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#rating" do 
    it "changes a review's rating, given a review" do 
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video)
      queue_item = Fabricate(:queue_item, user: user, video: video,
                                                          rating: 2)
      queue_item.rating = 5
      expect(Review.first.rating).to eq(5)
    end
    it "clears a review's rating, given a review" do 
      video = Fabricate(:video)
      user = Fabricate(:user)
      review = Fabricate(:review, user: user, video: video)
      queue_item = Fabricate(:queue_item, user: user, video: video,
                                                          rating: 2)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end
    it "creates a review and rating, in the absence of a review" do 
        video = Fabricate(:video)
        user = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: user, video: video)
        queue_item.rating = 4
        expect(Review.first.rating).to eq(4)
    end
  end

  describe "#category_name" do 
    it "returns the video's categorical name" do
      category = Fabricate(:category, name: "action")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq("action")
      end 
    end

    describe "#category" do 
      it "returns the video's category" do
      category = Fabricate(:category, name: "action")
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category) 
      end
    end
  end
