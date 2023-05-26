require "json"
require "open-uri"

# puts "Cleaning DB"
# Movie.destroy_all
# puts "DB now empty  "

url = "https://tmdb.lewagon.com/movie/top_rated"
# URI is a library in ruby to help read the url before parse
response = URI.open(url).read
# this makes it more readable
movies_data = JSON.parse(response)
movies = movies_data['results']

puts "Importing movies"
movies.each do |movie_data|
  title = movie_data['title']
  overview = movie_data['overview']
  rating = movie_data['vote_average']
  poster_url_base = "https://image.tmdb.org/t/p/original"
  poster_url = movie_data['poster_path']
  movie = Movie.new(title: title, overview: overview, rating: rating, poster_url: "#{poster_url_base}#{poster_url}")
  movie.save
end
puts "Movies have been created"
