# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title:"Fury",
             small_cover_url: "furry.sm.com",
             large_cover_url: "furry.lg.com",
             description: "Furry --lots of guns blazzing here.")
Video.create(title: "Equilizer",
             small_cover_url: "equilizer.sm.com",
             large_cover_url: "equilize.sm.com",
             description: " Equilizer, awesome movie.")
Video.create(title: "The November Man",
             small_cover_url: "tnm.sm.com",
             large_cover_url: "tnm.lg.com",
             description: "November, you gotta watch it.")
Video.create(title: "Hunger Games",
             small_cover_url: "hg.sm.com",
             large_cover_url: "hg.lg.com",
             description: "Hunger Games, its life or death.")
Video.create(title: " Jack Ryan",
             small_cover_url: "jr.sm.com",
             large_cover_url: "jr.sm.com",
             description: "Jack Ryan, action thriller, spies and terror!")