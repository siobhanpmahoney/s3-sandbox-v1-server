# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

3.times do
  album = Album.create(title: Faker::Music.album)
  4.times do
    song = Song.create(
      title: Faker::Music::GratefulDead.song,
      album_id: album.id)

      5.times do
        version = Version.create(
          date: DateTime.now,
          description: "#{Faker::Verb.ing_form} #{Faker::Music.chord} with #{Faker::Music.instrument}",
          s3_key: Faker::Alphanumeric.alphanumeric(number: 15),
          song_id: song.id
        )
      end
  end
end
