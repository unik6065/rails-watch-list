require 'open-uri'
require 'json'
require 'faker'

puts 'clean database'
Movie.delete_all
List.delete_all
Bookmark.delete_all


url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)['results']
puts 'add movies to the seed'
movies.each do |movie|

  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500/#{movie['poster_path']}",
    rating: movie['vote_average']
  )

  puts "created movie #{movie['title']}"

end

puts 'add lists to the seed'

25.times do
  list = List.create!(
    name: Faker::Name.unique.name
  )
  puts "create list #{list.name}"
  bookmark = Bookmark.create!(
    comment: Faker::Lorem.sentence,
    movie_id: Movie.all.sample.id,
    list_id: list.id
  )
  puts " -- create bookmark #{bookmark.comment}"

end

puts 'seed finished'
