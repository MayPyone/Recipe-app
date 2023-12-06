class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]

  # Action to generate the shopping list
  def shopping_list
    # Find the logged-in user's recipes
    user_recipes = current_user.reciipes

    # Retrieve all ingredients from the user's recipes
    all_recipe_ingredients = user_recipes.map(&:ingredients).flatten

    # Group ingredients by their associated food and calculate the total quantity needed
    ingredients_grouped_by_food = all_recipe_ingredients.group_by(&:name).transform_values do |ingredients|
      total_quantity = ingredients.sum(&:quantity)
      { quantity: total_quantity }
    end

    # Find the user's foods
    user_foods = current_user.foods

    # Calculate the missing ingredients for the shopping list
    shopping_list = {}
    ingredients_grouped_by_food.each do |food_name, data|
      user_food = user_foods.find_by(name: food_name)
      if user_food
        available_quantity = user_food.quantity
        required_quantity = data[:quantity]

        missing_quantity = required_quantity - available_quantity
        shopping_list[food_name] = missing_quantity if missing_quantity.positive?
      else
        shopping_list[food_name] = data[:quantity]
      end
    end

    # Calculate the total price of missing ingredients
    total_price = 0
    shopping_list.each do |food_name, missing_quantity|
      food = Food.find_by(name: food_name)
      if food
        price_per_unit = food.price
        total_price += price_per_unit * missing_quantity
      end
    end

    # Render the shopping list view with necessary data
    render 'shopping_list', locals: { shopping_list: shopping_list, total_price: total_price }
  end

  # GET /foods or /foods.json
  def index
    @foods = Food.all
  end

  # GET /foods/1 or /foods/1.json
  def show
  end

  # GET /foods/new
  def new
    @food = current_user.foods.build
  end

  # GET /foods/1/edit
  def edit
  end

  # POST /foods or /foods.json
  def create
    @food = Food.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to food_url(@food), notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to food_url(@food), notice: 'Food was successfully updated.' }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    @food.destroy!

    respond_to do |format|
      format.html { redirect_to foods_url, notice: 'Food was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_food
    @food = Food.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end
end
