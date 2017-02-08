require 'spec_helper'

describe Category do
  it "it saves itself" do 
    category = Category.new(name: "Comedy")
    category.save
    expect(Category.first).to eq(category)
  end
  
  it "has many videos" do 
    comedy = Category.create(name: "Comedy")
    monk = Video.create(title: "Monk", description: "interesting flick!", category_id: "comedy")

    south_park = Video.create(title: "South Park", description: "interesting flick!", category_id: "comedy")
    expect(commedy.videos).to eq(monk, south_park)
    has_many :videos, ~> {order("title")}
   end
 end