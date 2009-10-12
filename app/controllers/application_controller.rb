class ApplicationController < ActionController::Base
  before_filter :get_active_league, :set_locale
  filter_parameter_logging :password

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

  def set_language
    session[:locale] = params[:locale] || session[:locale]
    Gibberish.use_language(session[:locale] || :pl) { yield }
  end

  def get_active_league
    @active_league = League.active.first
  end

  def login_required
    unless current_user
      store_location
      flash[:notice] = t("controllers.require_user")
      redirect_to new_user_session_url
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
    I18n.locale = params[:locale] || cookies[:saps_locale]
  end
end
