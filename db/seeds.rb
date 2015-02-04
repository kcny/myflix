# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Categories

Category.create(name: "Action")
Category.create(name: "Adult Animation")
Category.create(name: "Comedy")
Category.create(name: "Documentary")

#Videos

      # Comedy

 
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 1) 
Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 1) 
Video.create(title: "Family Guy",
             description: "Adult animation, try it out.",
             small_cover_url: "/tmp/family_guy.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 1)  
Video.create(title: "Futurama",
             description: "Critically acclaimed, nominated 17 Annie Awards and 12 Emmy Awards, you might like it..",
             small_cover_url: "/tmp/futurama.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 1)
 
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 1) 
Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 1) 

      # Adult Animation

Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado USA.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 2)  
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 2)  
Video.create(title: "Family Guy",
             description: "Adult animation, try it out.",
             small_cover_url: "/tmp/family_guy.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 2)  
Video.create(title: "Futurama",
             description: "Critically acclaimed, nominated 17 Annie Awards and 12 Emmy Awards, you might like it..",
             small_cover_url: "/tmp/futurama.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 2)
Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado USA.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 2)  
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 2) 

      # Action

Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 3)  
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 3)  
Video.create(title: "Family Guy",
             description: "Adult animation, try it out.",
             small_cover_url: "/tmp/family_guy.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 3)  
Video.create(title: "Futurama",
             description: "Critically acclaimed, nominated 17 Annie Awards and 12 Emmy Awards, you might like it..",
             small_cover_url: "/tmp/futurama.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 3) 
Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 3)  
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 3)

      # Documentary

Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 4)  
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 4)  
Video.create(title: "Family Guy",
             description: "Adult animation, try it out.",
             small_cover_url: "/tmp/family_guy.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 4)  
Video.create(title: "Futurama",
             description: "Critically acclaimed, nominated 17 Annie Awards and 12 Emmy Awards, you might like it..",
             small_cover_url: "/tmp/futurama.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 4)
Video.create(title: "South Park",
             description: "A fictional mountain town in Colorado.",
             small_cover_url: "/tmp/south_park.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 4)  
Video.create(title: "Monk",
             description: "Adrian expereinces execessive compulsive disorder after the death of his wife.",
             small_cover_url: "/tmp/monk.jpg",
             # large_cover_url: "/tmp/monk_large.jpg",
             category_id: 4)  