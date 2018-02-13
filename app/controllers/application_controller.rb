class ApplicationController < ActionController::Base
  before_action :set_locale

  include Monban::ControllerHelpers
  protect_from_forgery with: :exception

  def require_login
    unless signed_in?
      redirect_to list_sources_path
    end
  end
  
  def require_admin
    unless signed_in?
      redirect_to list_sources_path
    end
  end

  def set_locale
    # I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = 'de'
  end
end
