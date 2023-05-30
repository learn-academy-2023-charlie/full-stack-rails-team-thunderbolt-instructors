class RecipeController < ApplicationController
  # displays all the instances
  def index
    # displays in ascending order
    @recipes = Recipe.all.order('id')
  end

  # displays one instance
  def show
    @recipe = Recipe.find(params[:id])
  end

  # displays an html form
  def new
    @recipe = Recipe.new
  end

  # saves the user input on the new html form
  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.valid?
      redirect_to recipes_path
    else
      redirect_to new_path
    end
  end

  # displays an html form
  def edit
    @recipe = Recipe.find(params[:id])
  end

  # saves the user input on the edit html form
  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    if @recipe.valid?
      redirect_to recipe_path(@recipe)
    else
      redirect_to edit_recipe_path
    end
  end

  # removes an instance
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  # restricts access to data
  private
  # strong params method to state what attributes can be created or updates
  def recipe_params
    params.require(:recipe).permit(:chef, :cuisine)
  end
end
