class VegetablesController < ApplicationController
  before_action :require_login
  before_action :set_vegetable, only: [:show, :edit, :update, :destroy]

  # GET /vegetables
  def index
    @vegetables = Vegetable.paginate(page: params[:page], per_page: 48).order(title: :asc)
  end

  # GET /vegetables/new
  def new
    @vegetable = Vegetable.new
  end

  # GET /vegetables/1/edit
  def edit
  end

  # POST /vegetables
  def create
    @vegetable = Vegetable.new(vegetable_params)

    if @vegetable.save
      redirect_to vegetables_path(anchor: @vegetable.id), notice: 'Vegetable was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /vegetables/1
  def update
    if @vegetable.update(vegetable_params)
      redirect_to vegetables_path(anchor: @vegetable.id), notice: 'Vegetable was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /vegetables/1
  def destroy
    @vegetable.destroy
    redirect_to vegetables_url, notice: 'Vegetable was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vegetable
      @vegetable = Vegetable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vegetable_params
      params.require(:vegetable).permit(:title, :price)
    end
end
