class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    #displays a list of all recipes
    #contains links to each recipe's show page
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    #displays recipe attributes
    #contains a form to delete the recipe
    @recipes = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes' do
    @recipes = Recipe.create(params)
    redirect "/recipes/#{@recipes.id}"
  end

  get '/recipes/:id/edit' do
    #edit recipe and displays ingredients before editing
    @recipes = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do 
    @recipes = Recipe.find(params[:id])
    @recipes.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{@recipes.id}"
  end

  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    redirect '/recipes'
  end
end
