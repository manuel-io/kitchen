class RecipePartsController < ApplicationController
  before_action :require_login
  before_action :set_recipe_part, only: [:show, :edit, :update, :destroy]

  # GET /recipe_parts
  # GET /recipe_parts.json
  def index
#    @recipe_parts = RecipePart.all
    @recipes = Recipe.all.order(title: :asc)
  end

  # GET /recipe_parts/1
  # GET /recipe_parts/1.json
  def show
  end

  # GET /recipe_parts/new
  def new
    @recipe_part = RecipePart.new
  end

  # GET /recipe_parts/1/edit
  def edit
  end

  # POST /recipe_parts
  # POST /recipe_parts.json
  def create
    part = params[:recipe_part].delete :part
    reflection = Recipe.parts.detect { |val| val.name == part.to_sym }

    type = case reflection.class_name
      when 'connection'
        Connection.new(child_id: params[:recipe_part][:child_id], scale: params[:recipe_part][:scale])
      when 'component'
        Component.new
    end

    if type.save
      @recipe = Recipe.find(params[:recipe_part][:recipe_id])
      @recipe_part = @recipe.recipe_parts.build(recipe_part_params.merge(part: type))

      if @recipe_part.save
        redirect_to recipe_parts_path(anchor: @recipe_part.recipe.id), notice: 'Recipe part was successfully created.'
      else
        render :new
      end
    else
      # @recipe_part = RecipePart.new
      flash[:alert] = type.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /recipe_parts/1
  def update
    if @recipe_part.update(recipe_part_params)
      redirect_to recipe_parts_path(anchor: @recipe_part.recipe.id), notice: 'Recipe part was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /recipe_parts/1
  def destroy
    @recipe_part.destroy
    redirect_to recipe_parts_path(anchor: @recipe_part.recipe.id), notice: 'Recipe part was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_part
      @recipe_part = RecipePart.find(params[:id])
    end

    def recipe_part_params
      params.require(:recipe_part).permit(:title, :description)
    end
end
