require "sinatra"
require "sinatra/reloader" if development?
require "byebug"
require "better_errors"
require_relative 'cookbook'
require_relative 'recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

cookbook = Cookbook.new('recipes.csv')

# View
#--------------------------------

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

# Model
#--------------------------------

post '/delete_recipe' do
  cookbook.remove_recipe(params[:index].to_i - 1)
  redirect "/"
end

post '/add_recipe' do
  recipe = Recipe.new(params[:name], params[:description], params[:prep_time], params[:difficulty], false)
  cookbook.add_recipe(recipe)
  redirect "/"
end
