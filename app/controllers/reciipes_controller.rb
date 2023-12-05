class ReciipesController < ApplicationController
  before_action :set_reciipe, only: %i[ show edit update destroy ]

  # GET /reciipes or /reciipes.json
  def index
    @reciipes = Reciipe.all
  end

  # GET /reciipes/1 or /reciipes/1.json
  def show
  end

  # GET /reciipes/new
  def new
    @reciipe = current_user.reciipes.build
  end

  # GET /reciipes/1/edit
  def edit
  end

  # POST /reciipes or /reciipes.json
  def create
    @reciipe = Reciipe.new(reciipe_params)

    respond_to do |format|
      if @reciipe.save
        format.html { redirect_to reciipe_url(@reciipe), notice: "Reciipe was successfully created." }
        format.json { render :show, status: :created, location: @reciipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reciipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reciipes/1 or /reciipes/1.json
  def update
    respond_to do |format|
      if @reciipe.update(reciipe_params)
        format.html { redirect_to reciipe_url(@reciipe), notice: "Reciipe was successfully updated." }
        format.json { render :show, status: :ok, location: @reciipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reciipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reciipes/1 or /reciipes/1.json
  def destroy
    @reciipe.destroy!

    respond_to do |format|
      format.html { redirect_to reciipes_url, notice: "Reciipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reciipe
      @reciipe = Reciipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reciipe_params
      params.require(:reciipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user_id)
    end
end
