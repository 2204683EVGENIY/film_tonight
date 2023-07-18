require "net/http"
require "addressable/uri"
require "nokogiri"
require_relative "film"

module FilmParser
  extend self
  WIKI_IMDB_250_URL = "https://ru.wikipedia.org/wiki/250_лучших_фильмов_по_версии_IMDb".freeze
  def from_wiki_imdb250
    uri = Addressable::URI.parse(WIKI_IMDB_250_URL)
    response = Net::HTTP.get_response(uri)
    doc = Nokogiri::HTML(response.body)
    doc.css("table.sortable tr:not(:first-child)").map do |tr|
      title = tr.at("td:nth-of-type(2)").text
      director = tr.at("td:nth-of-type(4)").text
      year = tr.at("td:nth-of-type(3)").text.to_i

      Film.new(title, director, year)
    end
  end
end
