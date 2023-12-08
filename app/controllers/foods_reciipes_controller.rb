class FoodsReciipesController < ApplicationController
  def new
    @recipe = Reciipe.find(params[:reciipe_id])
    @recipe_food = FoodReciipe.new
    @foods = current_user.foods
  end

  def create
    @recipe_food = FoodReciipe.where(food_id: params[:food_reciipe][:food_id],
                                     reciipe_id: params[:food_reciipe][:reciipe_id]).first
    if @recipe_food
      @recipe_food.quantity += params[:food_reciipe][:quantity].to_i
    else
      @recipe_food = FoodReciipe.new(recipe_food_params)
    end

    saved = @recipe_food.save

    redirect_to reciipe_path(params[:food_reciipe][:reciipe_id].to_i) if saved
  end

  def destroy
    @recipe = Reciipe.find(params[:reciipe_id])
    @recipe_food = FoodReciipe.find(params[:id])
    @recipe_food.destroy

    redirect_to reciipe_path(@recipe), notice: 'Food recipe item was successfully removed.'
  end

  def general_shopping_list
    @total = 0
    @all_recipe_foods = list_recipe_foods
    @shopping_list = what_food_to_buy?(@all_recipe_foods)
    @shopping_list.each do |item|
      @total += item[:price]
    end
    @total
  end

  private

  def recipe_food_params
    params.require(:food_reciipe).permit(:quantity, :food_id, :reciipe_id)
  end

  def this_food?(base, item)
    @food_element = nil
    base.each do |element|
      @food_element = element if item == element[:food]
    end
    @food_element
  end

  # rubocop:disable Metrics/MethodLength
  def list_recipe_foods
    @all_foods = []
    @all_recipes = current_user.reciipes
    @all_recipes.each do |recipe_item|
      recipe_item.foods_reciipes.each do |recipe_food_item|
        next if recipe_food_item.food.nil?

        @food = this_food?(@all_foods, recipe_food_item.food.name)
        if @food
          @index_food = @all_foods.index(@food)
          @all_foods[@index_food][:quantity] += recipe_food_item.quantity
          @all_foods[@index_food][:price] = recipe_food_item.food.price * @all_foods[@index_food][:quantity]
        else
          @food = {} if @food.nil?
          @food[:id] = recipe_food_item.food.id
          @food[:food] = recipe_food_item.food.name
          @food[:quantity] =
            recipe_food_item.quantity.to_i
          @food[:price] = recipe_food_item.food.price * @food[:quantity]
          @food[:unit] = recipe_food_item.food.measurement_unit
          @all_foods.push(@food)
        end
      end
    end
    @all_foods
  end
  # rubocop:enable Metrics/MethodLength

  def what_food_to_buy?(all_recipes_foods)
    @food_to_buy = []
    all_recipes_foods.each_with_index do |recipe_item, _index|
      current_food = Food.where(user: current_user, id: recipe_item[:id]).first
      if current_food.quantity.to_i < recipe_item[:quantity].to_i
        recipe_item[:quantity] -= current_food.quantity
        @food_to_buy.push(recipe_item)
      end
    end
    @food_to_buy
  end
end
