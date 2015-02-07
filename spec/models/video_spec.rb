require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Monk", description: "Good movie")
                                      video.save
                                      expect(Video.first).to eq(video)  
  end

  it "belongs to category" do 
    adult_animation = Category.create(name: "Adult Animation")
    south_park = Video.create(title: "South Park", description: "too funny!",
                                                  category: adult_animation)
                          expect(south_park.category).to eq(adult_animation)
  end

  it "does not allow the creation of a video without a title" do
    video = Video.new(description: "Good movie")
    expect(Video.count).to eq(0)

end
  it "does not allow the creation of a video without a description" do
    video = Video.new(title: "Good movie")
    expect(Video.count).to eq(0)
  end
end