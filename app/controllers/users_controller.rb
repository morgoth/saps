# encoding: UTF-8

class UsersController < ApplicationController
  before_filter :login_required
  before_filter :account_owner, :only => [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User #{@user.login} created"
      redirect_to users_path
    else
      render :new
    end
  end

  def index
    @users = User.all(:order => :login)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Zmieniono hasło.'
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    id = params[:id]
    if id && user = User.find(id)
      begin
        user.safe_delete
        flash[:notice] = "User #{user.login} usunięty"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to users_path
  end

  private

  def account_owner
    unless current_user == User.find(params[:id])
      redirect_to users_path
      flash[:notice] = "Can't edit"
    end
  end
end
