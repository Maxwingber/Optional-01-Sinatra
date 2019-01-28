require 'nokogiri'
require 'open-uri'
require 'byebug'

class Scraper
  def initialize; end

  def scrape(ingredient)
    recipes = []
    html_file = open("https://www.chefkoch.de/rs/s0/#{ingredient}/Rezepte.html").read
    html_doc = Nokogiri::HTML(html_file)
    # search for element
    # byebug
    html_doc.search('.rsel-recipe').each do |element|
      name = ""
      description = ""
      prep_time = 0
      difficulty = ""

      # Search for name
      element.search('.ds-heading-link').each do |name_n|
        name = name_n.text.strip
      end
      # Search for description
      element.search('.recipe-text').each do |description_n|
        description = description_n.text.strip
      end
      # Search for prep_time
      element.search('.recipe-preptime').each do |prep_time_n|
        prep_time = prep_time_n.text.scan(/\d+/).join.strip
      end
      # Search for difficulty
      element.search('.recipe-difficulty').each do |difficulty_n|
        difficulty = difficulty_n.text.scan(/ \w+/).join.strip
      end
      recipes << [name, description, prep_time, difficulty]
    end
    recipes
  end
end
