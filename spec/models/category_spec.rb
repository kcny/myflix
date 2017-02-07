require 'spec_helper'

describe Category do
  it {should have_many(:videos)}
  it { should validate_presence_of(:name) }

  describe "#recent_videos" do 
    it "returns reverse chronological order." do 
      drama = Category.create(name: "drama")
      sarafina = Video.create(title: "Sarafina", description: "I like it!",
                                                  category: drama,
                                                  created_at: 1.day.ago) 
                                                 

      mandela = Video.create(title: "Mandela", description: "Political thriller!",
                                               category: drama) 
                                                
      expect(drama.recent_videos).to eq([mandela, sarafina])
    end
    it "returns all videos if the total videos found are less than six." do 
      drama = Category.create(name: "drama")
      sarafina = Video.create(title: "Sarafina", description: "I like it!",
                                                  category: drama,
                                                  created_at: 1.day.ago) 
                                                 

      mandela = Video.create(title: "Mandela", description: "Political thriller!",
                                               category: drama) 
                                                
      expect(drama.recent_videos.count).to eq(2)
    end
    it "returns six videos if total videos found are greater than six." do 
      drama = Category.create(name: "drama")
      10.times { Video.create(title: "Sarafina", description: "I like it!",
                                                  category: drama)}
      expect(drama.recent_videos.count).to eq(6)
    end

    it "returns six of the most the recent videos." do 
      drama = Category.create(name: "drama")
      6.times { Video.create(title: "Sarafina", description: "I like it!",
                                                  category: drama)}

      neria = Video.create(title: "Neria", description: "Tough widow story!",
                                               category: drama,
                                               created_at: 3.days.ago) 
      expect(drama.recent_videos).not_to include(neria)
    end
    it "returns an empty array if search results are empty." do 
      drama = Category.create(name: "drama")
      expect(drama.recent_videos).to eq([])
    end
  end
 end