class ApplicationController < ActionController::Base
  include Monban::ControllerHelpers
  protect_from_forgery with: :exception

  def require_login
    unless signed_in?
      redirect_to root_path
    end
  end
  
  def require_admin
    unless signed_in?
      redirect_to root_path
    end
  end
end
