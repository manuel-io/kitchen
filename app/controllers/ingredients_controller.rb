class IngredientsController < ApplicationController
  before_action :require_login
  before_action :set_ingredient, only: [:edit, :update, :destroy]

  # GET /ingredients/new
  def new
    #render plain: Component.methods
    @component = Component.find(params[:component_id])
    @ingredient = @component.ingredients.build
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @component = Component.find(params[:component_id])
    @ingredient = @component.ingredients.create(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to component_path(@component), notice: 'Ingredient was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to component_path(@component), notice: 'Ingredient was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
#    render plain: params.inspect
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to component_path(params[:component_id]), notice: 'Ingredient was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @component = Component.find(params[:component_id])
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:amount, :unit, :title, :component_id, :product_id)
    end
end
