class RecipeController < ApplicationController
  # displays all the instances
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
