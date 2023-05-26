class InstructionController < ApplicationController
  def index
    @recipe = Recipe.find(params[:id])
    @instructions = @recipe.instructions
  end
end
