class UsersController < ApplicationController
  before_filter :login_required

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

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User destroyed"
      redirect_to users_path
    else
      flash[:notice] = "User can not be destroyed"
      redirect_to users_path
    end
  end
end
