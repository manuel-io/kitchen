class ApplicationController < ActionController::Base
  before_action :set_locale, :set_published

  include Oath::ControllerHelpers
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
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_published
    pub = params[:published] || false
    pub = signed_in? ? false : pub
    @published = ActiveModel::Type::Boolean.new.cast(pub)
  end

  def default_url_options
    { locale: I18n.locale, published: @published }
  end
end
