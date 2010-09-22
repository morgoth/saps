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
      redirect_to users_path, :notice => "User destroyed"
    else
      redirect_to users_path, :alert => "User can not be destroyed"
    end
  end
end
