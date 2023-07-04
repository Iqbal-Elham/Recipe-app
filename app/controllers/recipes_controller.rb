class RecipesController < ApplicationController
  # before_action :set_recipe, only: %i[show destroy]
  # include RecipesHelper

  def index
    @recipes = Recipe.where(user_id: current_user.id)
    # @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(user_id: current_user.id, **recipe_params)
    if @recipe.save
      flash[:notice] = 'Recipe created successfully'
      redirect_to recipes_path
    else
      flash[:alert] = 'Recipe creation failed'
      render :new
    end
  end

  def toggle_visibility
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    @recipe.save

    redirect_to request.referrer
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to request.referrer
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :prepation_time, :cooking_time, :public)
  end
end
