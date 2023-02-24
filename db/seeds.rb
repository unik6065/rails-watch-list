require 'open-uri'
require 'json'
require 'faker'

puts 'clean database'
Bookmark.destroy_all if Rails.env.development?
Movie.delete_all
List.delete_all


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

10.times do
  list = List.create!(
    name: Faker::Name.unique.name
  )
  puts "created list #{list.name}"
end

puts 'add bookmark to the seed'


List.all.each do |list|
  movies = Movie.all
  movies = movies.to_a
  movie = movies.shuffle
  i = 2
  rand(2..4).times do
    puts 'choose a movie'
    movie = movies[i * 3]
    i += 1
    puts movie.title
    puts "--#{list.name}"
    Bookmark.create!(list: list, movie: movie, comment: Faker::Lorem.sentence)
    puts 'bookmark created'
  end
end

# lotr = Movie.create!(title: 'le seigner des anneaux', overview: 'Le meilleur film du monde', rating: 10)
# harry = Movie.create!(title: 'harry potter', overview: 'un bon film', rating: 8)

# list1 = List.create!(name: 'mes films de 2022')

# Bookmark.create!(movie: lotr, list: list1, comment: 'has to be seen')
# Bookmark.create!(movie: harry, list: list1, comment: 'choice of all')

puts 'seed finished'
