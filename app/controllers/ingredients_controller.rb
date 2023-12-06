class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[show edit update destroy]
  before_action :set_reciipe, only: %i[index new]

  # GET /ingredients or /ingredients.json
  def index
    @ingredients = Ingredient.all
  end

  # GET /ingredients/1 or /ingredients/1.json
  def show
    @ingredient = Ingredient.find_by(id: params[:id])
  end

  # GET /ingredients/new
  def new
    @reciipe = Reciipe.find(params[:reciipe_id])
    @ingredient = @reciipe.ingredients.build
  end

  # GET /ingredients/1/edit
  def edit
    @reciipe = Reciipe.find(params[:reciipe_id])
    @ingredient = @reciipe.ingredients.find(params[:id])
  end

  # POST /ingredients or /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to reciipe_path(@ingredient.reciipe), notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1 or /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to reciipe_ingredient_url(@ingredient.reciipe, @ingredient), notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1 or /ingredients/1.json
  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to reciipe_path(@ingredient.reciipe), notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :measurement_unit, :value, :reciipe_id)
  end

  def set_reciipe
    @reciipe = Reciipe.find(params[:reciipe_id])
  end
end
