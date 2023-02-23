require 'open-uri'
require 'json'

puts 'clean database'
Movie.delete_all
puts 'add movies to the seed'

url = 'https://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)['results']

movies.each do |movie|

  Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: movie['poster_path'],
    rating: movie['vote_average']
  )

  puts "created movie #{movie['title']}"

end

puts 'seed finished'
