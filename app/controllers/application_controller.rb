class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
  helper_method :current_user_session, :current_user, :logged_in?

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  alias :logged_in? :current_user

  def login_required
    unless current_user
      store_location
      redirect_to new_user_session_url, :notice => t("flash.require_user")
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def set_locale
    cookies[:saps_locale] = params[:locale] if params[:locale]
    I18n.locale = params[:locale] || cookies[:saps_locale] || I18n.default_locale
  end
end
