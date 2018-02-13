class SessionsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create], raise: false

  def index
  end

  def new
    redirect_to session_path if signed_in?
  end

  def create
    user = authenticate_session(session_params)

    if sign_in(user)
      redirect_to recipes_path
    else
      render :new
    end
  end

  def logout
    destroy
  end

  private

  def destroy
    sign_out
    redirect_to root_path
  end
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
