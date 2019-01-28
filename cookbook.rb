require 'csv'
require_relative 'recipe'

class Cookbook
  attr_reader :recipes

  # Loads existing Recipe from the CSV
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path

    read_csv
  end

  # Returns all the recipes
  def all
    @recipes
  end

  # Adds a new recipe to the cookbook
  def add_recipe(new_recipe)
    @recipes << new_recipe
    write_csv
  end

  # Removes a recipe from the cookbook
  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    write_csv
  end

  def mark(index)
    @recipes[index].mark!
    write_csv
  end

  private

  def read_csv
    CSV.foreach(@csv_file_path) do |row|
      unless row[0].nil?
        last_value = (row[4] == "true")
        recipe_placeholder = Recipe.new(row[0], row[1], row[2], row[3].to_s, last_value)
        @recipes << recipe_placeholder
      end
    end
  end

  def write_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.marked]
      end
    end
  end
end

