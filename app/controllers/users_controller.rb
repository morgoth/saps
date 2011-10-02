class UsersController < ApplicationController
  before_filter :login_required

  def index
    @users = User.all(:order => :login)
  end

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
end
