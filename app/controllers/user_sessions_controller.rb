class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = t("flash.logged_in")
      redirect_back_or_default posts_path
    else
      render :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = t("flash.logged_out")
    redirect_back_or_default posts_path
  end
end
