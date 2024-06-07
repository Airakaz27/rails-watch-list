# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

puts 'Cleaning database...'
Movie.destroy_all
List.destroy_all

url = 'https://tmdb.lewagon.com/movie/popular'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

puts 'Creating movies...'

movies['results'].each do |result|
  movie = {
    title: result['title'],
    overview: result['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{result['poster_path']}",
    rating: result['vote_average']
  }
  Movie.create!(movie)
  puts "Created #{movie['title']}"
end
puts 'Finished!'

puts 'Create Action list'
List.create!({ name: 'Action', image_url: "https://m.media-amazon.com/images/I/71JXK7v7pvL._AC_UF894,1000_QL80_.jpg" })
puts 'Create Comedy list'
# Create Comedy list
List.create!({ name: 'Comedy', image_url: "https://fr.web.img2.acsta.net/pictures/21/06/28/17/13/1668165.jpg" })
