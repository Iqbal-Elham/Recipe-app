class RecipesController < ApplicationController
  # before_action :set_recipe, only: %i[show destroy]
  before_action :authenticate_user!, only: %i[show toggle_visibility shopping_list]
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
    if @recipe.user == current_user
      @recipe.public = !@recipe.public
      @recipe.save
    else
      flash[:notice] = 'Only owner can update visibility'
    end

    redirect_to request.referrer
  end

  def shopping_list
    @recipes = Recipe.where(user: current_user)
    @foods = Food.where(user: current_user)

    @missing_foods = []
    @total_value = 0
    @recipes.each do |recipe|
      recipe.recipes_foods.each do |recipes_food|
        unless @foods.include?(recipes_food.food)
          @missing_foods << recipes_food
          @total_value += (recipes_food.food.price * recipes_food.quantity)
        end
      end
    end
    render 'shopping_list'
  end

  def edit
    @recipe = Recipe.find(params[:id])
    render 'ingredient'
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      # Check if a food has been selected
      if params[:recipe][:food_id].present? && params[:recipe][:food_quantity].present?
        food = Food.find(params[:recipe][:food_id])
        quantity = params[:recipe][:food_quantity].to_i
        puts quantity
        @recipe.recipes_foods.create(food:, quantity:)
      end

      redirect_to @recipe, notice: 'Recipe updated successfully.'
    else
      render :edit
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    return if @recipe.user == current_user || @recipe.public

    flash[:notice] = 'The recipe is not public nor yours'
    redirect_to recipes_path
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
