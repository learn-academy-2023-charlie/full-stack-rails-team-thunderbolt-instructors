class RecipeController < ApplicationController
  # displays all the instances
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.valid?
      redirect_to recipes_path
    else
      redirect_to new_path
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    if @recipe.valid?
      redirect_to recipe_path(@recipe)
    else
      redirect_to edit_recipe_path
    end
  end


  # strong params to state what attributes can be created
  private
  def recipe_params
    params.require(:recipe).permit(:chef, :cuisine)
  end
end
