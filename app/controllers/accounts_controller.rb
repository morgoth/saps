class AccountsController < ApplicationController
  before_filter :login_required

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to account_path, :notice => t("flash.accounts.update.notice")
    else
      render :edit
    end
  end
end
