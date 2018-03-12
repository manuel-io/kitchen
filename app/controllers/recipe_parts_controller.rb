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
        Connection.new(child_id: params[:recipe_part][:child_id])
      when 'component'
        Component.new
    end

    @recipe = Recipe.find(params[:recipe_part][:recipe_id])

    if type.save
      @recipe_part = @recipe.recipe_parts.new(title: params[:recipe_part][:title], part: type)
      if @recipe_part.save
        redirect_to recipe_parts_path(anchor: @recipe_part.recipe.id), notice: 'Recipe part was successfully created.'
      else
        render :new
      end
    else
      @recipe_part = RecipePart.new
      flash[:alert] = v.errors.full_messages
      render :new
    end
  end

  # PATCH/PUT /recipe_parts/1
  # PATCH/PUT /recipe_parts/1.json
  def update
    respond_to do |format|
      if @recipe_part.update(recipe_part_edit_params)
        format.html { redirect_to recipe_parts_path(anchor: @recipe_part.recipe.id), notice: 'Recipe part was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe_part }
      else
        format.html { render :edit }
        format.json { render json: @recipe_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_parts/1
  # DELETE /recipe_parts/1.json
  def destroy
    @recipe_part.destroy
    redirect_to recipe_parts_path(anchor: @recipe_part.recipe.id), notice: 'Recipe part was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_part
      @recipe_part = RecipePart.find(params[:id])
    end

    def recipe_part_edit_params
      params.require(:recipe_part).permit(:title, :description)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_part_new_params
      params.require(:recipe_part).permit(:title, :description, :recipe_id, :part_id)
    end
end
