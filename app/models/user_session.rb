class UserSession < Authlogic::Session::Base
  before_validation :strip_login

  find_by_login_method :find_by_username_or_email

  def strip_login
    login.strip! unless login.blank?
  end
end
