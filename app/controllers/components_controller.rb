class ComponentsController < ApplicationController
  before_action :require_login
  before_action :set_component, only: [:show]

  # GET /components/1
  # GET /components/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_params
      params.require(:component).permit(:description)
    end
end
