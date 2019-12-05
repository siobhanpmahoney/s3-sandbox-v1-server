# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# {
#   title: "Appliance",
#   versions: [
#     {
#       date: "20190504",
#       s3_key: "Oct012019/album2/Appliance/20190504.m4a",
#       etag: "08f0d43c100331b6148e4fb03d3cc02c",
#     },
#     {
#       date: "20190507",
#       s3_key: "Oct012019/album2/Appliance/20190507.m4a",
#       etag: "4a2a441881d08846c09b2160da522b0c",
#     },
#     {
#       date: "20190611",
#       s3_key: "Oct012019/album2/Appliance/20190611.m4a",
#       etag: "995418116e6b01c0d88457dfcfc6971a",
#     },
#     {
#       date: "20190702",
#       s3_key: "Oct012019/album2/Appliance/20190702.m4a",
#       etag: "cb7d2e6ab5d85c43abe4c2b8af9619f9",
#     },
#     {
#       date: "20190720",
#       s3_key: "Oct012019/album2/Appliance/20190720.m4a",
#       etag: "8b02861e7f3b3ebfa4afc7872df3b33a",
#     }
#   ]
# },

# album = {
#   title: "album2",
#   songs: [

#     {
#       title: "Aviary",
#       versions: [
#         {
#           date: "20190504.m4a",
#           etag: "58e4b4fce9476fc20a630d7a8e3f1034",
#           s3_key: "Oct012019/album2/Aviary/20190504.m4a"
#         },
#         {
#           date: "20190507.m4a",
#           etag: "e16b0aa1f83c25b0bf7fb80f22ff88fd",
#           s3_key: "Oct012019/album2/Aviary/20190507.m4a"
#         },
#         {
#           date: "20190702.m4a",
#           etag: "e094c5d7ea898dccacaefffe63122d59",
#           s3_key: "Oct012019/album2/Aviary/20190702.m4a"
#         },
#         {
#           date: "20190720.m4a",
#           etag: "aa6d9c4cd39172ab9134c6bd18d4c0a9",
#           s3_key: "Oct012019/album2/Aviary/20190720.m4a"
#         }
#       ]
#     },
#     {
#       title: "Shut Up and Dance",
#       versions: [
#         {
#           date: "20190618.m4a",
#           s3_key: "Oct012019/album2/Shut Up and Dance/20190618.m4a",
#           etag: "b5992b23d28d2d07f1475f5ad03ba7cf"
#         },
#         {
#           date: "20190702.m4a",
#           s3_key: "Oct012019/album2/Shut Up and Dance/20190702.m4a",
#           etag: "25c620f8f7daf6788ee5bb43aeb62768"
#         },
#         {
#           date: "20190720.m4a",
#           s3_key: "Oct012019/album2/Shut Up and Dance/20190720.m4a",
#           etag: "9149899fd1ae6fb60d6ffe585f47d81a"
#         },
#         {
#           date: "20190820.m4a",
#           s3_key: "Oct012019/album2/Shut Up and Dance/20190820.m4a",
#           etag: "a9da85d24745f0dc4b5108dad540bfa2"
#         }
#       ]
#     }
#   ]
# }

# a = Album.create(title: album[:title])

# album[:songs].each do |song|
#   s = Song.find_or_create_by(title: song[:title], album_id: 3)
#   puts "song"
#   puts song
#   song[:versions].each do |version|
#     v = Version.create(song_id: s[:id], date: version[:date], s3_key: version[:s3_key], etag: version[:etag])
#     puts "version:"
#     puts v
#   end
# end





Version.all.each do |v| 
  if !v.date
    v.update(date: Faker::Date.in_date_period)
  end 

  descriptions = ["#{Faker::Verb.ing_form} #{Faker::Music.chord}", "#{Faker::Verb.ing_form} #{Faker::Music.key}", "#{Faker::Verb.ing_form} #{Faker::Music.instrument}"]

    v.update(description: descriptions.sample)

end

