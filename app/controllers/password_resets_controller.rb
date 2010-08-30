class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
  end

  def create
    @user = User.find_by_email(params[:password_reset][:email])
    if @user
      @user.deliver_password_reset_instructions!
      redirect_to root_url, :notice => t("flash.password_resets.create.notice")
    else
      flash[:error] = t("flash.password_resets.create.alert")
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => t("flash.password_resets.update.notice")
    else
      render :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    redirect_to root_url, :alert => t("flash.password_resets.not_found.alert") unless @user
  end
end
