require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Monk", description: "Good movie", small_cover_url: "/tmp/monk.jpg",
                                      large_cover_url: "/tmp/monk_large.jpg", category_id: 2 )
                                      video.save
                                      expect(Video.first.title).to eq("Monk")  
  end
end