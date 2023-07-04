class RecipesFoodsController < ApplicationController
  before_action :authenticate_user!

  # GET /foods/new
  def new
    @food = Food.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    rf_params = params[:food]
    respond_to do |format|
      if @food.save
        recipe_food = RecipesFood.new(recipe_id: rf_params[:recipe_id], food_id: @food.id,
                                      quantity: rf_params[:quantity])
        recipe_food.save
        format.html { redirect_to recipe_path(params[:food][:recipe_id]), notice: 'Food was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
