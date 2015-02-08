require 'spec_helper'

describe Video do

  it { should belong_to(:category)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of (:description)}

  describe "search by title" do 
    it "returns an empty array if there is no match." do 
      sarafina = Video.create(title: "Sarafina", description: "I like it!")
      mandela = Video.create(title: "Mandela", description: "Political thriller!")
      expect(Video.search_by_title("find")).to eq([])
    end
    it "returns an array of one video if there is one match exact match." do 
      sarafina = Video.create(title: "Sarafina", description: "I like it!")
      mandela = Video.create(title: "Mandela", description: "Political thriller!")
      expect(Video.search_by_title("Sarafina")).to eq([sarafina])
    end
    it "returns an array of one video if there is a partial match." do 
      sarafina = Video.create(title: "Sarafina", description: "I like it!")
      mandela = Video.create(title: "Mandela", description: "Political thriller!")
      expect(Video.search_by_title("dela")).to eq([mandela])
    end
    it "returns an array of several video matches ordered by created_at." do
      sarafina = Video.create(title: "Sarafina", description: "I like it!", 
                                                      created_at: 1.day.ago)

      mandela = Video.create(title: "Mandela", description: "Political thriller!")
      expect(Video.search_by_title("a")).to eq([mandela, sarafina])
    end
    it "returns an empty array for a search with an empty string" do
      sarafina = Video.create(title: "Sarafina", description: "I like it!", 
                                                      created_at: 1.day.ago)

      mandela = Video.create(title: "Mandela", description: "Political thriller!")
      expect(Video.search_by_title("")).to eq([])
    end

  end
end