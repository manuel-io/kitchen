class SeasonningsController < ApplicationController
  before_action :set_seasonning, only: [:show, :edit, :update, :destroy]

  # GET /seasonnings
  # GET /seasonnings.json
  def index
    @seasonnings = Seasonning.all
  end

  # GET /seasonnings/1
  # GET /seasonnings/1.json
  def show
  end

  # GET /seasonnings/new
  def new
    @seasonning = Seasonning.new
  end

  # GET /seasonnings/1/edit
  def edit
  end

  # POST /seasonnings
  # POST /seasonnings.json
  def create
    @seasonning = Seasonning.new(seasonning_params)

    respond_to do |format|
      if @seasonning.save
        format.html { redirect_to @seasonning, notice: 'Seasonning was successfully created.' }
        format.json { render :show, status: :created, location: @seasonning }
      else
        format.html { render :new }
        format.json { render json: @seasonning.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seasonnings/1
  # PATCH/PUT /seasonnings/1.json
  def update
    respond_to do |format|
      if @seasonning.update(seasonning_params)
        format.html { redirect_to @seasonning, notice: 'Seasonning was successfully updated.' }
        format.json { render :show, status: :ok, location: @seasonning }
      else
        format.html { render :edit }
        format.json { render json: @seasonning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seasonnings/1
  # DELETE /seasonnings/1.json
  def destroy
    @seasonning.destroy
    respond_to do |format|
      format.html { redirect_to seasonnings_url, notice: 'Seasonning was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seasonning
      @seasonning = Seasonning.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seasonning_params
      params.require(:seasonning).permit(:title, :amount, :price)
    end
end
