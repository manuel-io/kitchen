class ConnectionsController < ApplicationController
  before_action :set_connection, only: [:show, :edit, :update]

  # GET /connections/1
  def show
  end

  # GET /connections/1/edit
  def edit
  end

  # PATCH/PUT /connections/1
  def update
    if @connection.update(connection_params)
      redirect_to @connection, notice: 'Connection was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_connection
      @connection = Connection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def connection_params
      params.require(:connection).permit(:child_id, :scale)
    end
end
