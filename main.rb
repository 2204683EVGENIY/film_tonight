require_relative "lib/film_parser"

films = FilmParser.from_wiki_imdb250

directors = films.map(&:director).uniq

puts 'Фильм какого режиссёра вам предложить?'

directors.each.with_index(1) do |director, id|
  puts "#{id}. #{director}"
end

until (user_choice = $stdin.gets.to_i).between?(1, directors.size)
  puts 'Выберите правильный номер'
end

selected_director = directors[user_choice - 1]

puts films.select { |film| film.director == selected_director }.sample
