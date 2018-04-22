class IngredientsController < ApplicationController
  before_action :require_login
  before_action :set_ingredient, only: [:edit, :update, :destroy]

  # GET /ingredients/new
  def new
    @component = Component.find(params[:component_id])
    @ingredient = @component.ingredients.build
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients
  def create
    adding = case params[:ingredient][:uid]
      when /Vegetable(\d+)/ then Vegetable.find($1)
      when /Product(\d+)/ then Product.find($1)
    end

    @component = Component.find(params[:component_id])
    @ingredient = @component.ingredients.build(ingredient_params.merge(adding: adding))
    
    if @ingredient.save
      redirect_to component_path(@component), notice: 'Ingredient was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ingredients/1
  def update
    adding = case params[:ingredient][:uid]
      when /Vegetable(\d+)/ then Vegetable.find($1)
      when /Product(\d+)/ then Product.find($1)
    end
    
    if @ingredient.update(ingredient_params.merge(adding: adding))
      redirect_to component_path(@component), notice: 'Ingredient was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ingredients/1
  def destroy
    @ingredient.destroy
    redirect_to component_path(params[:component_id]), notice: 'Ingredient was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @component = Component.find(params[:component_id])
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:amount, :unit, :title, :component_id, :adding_id)
    end
end
