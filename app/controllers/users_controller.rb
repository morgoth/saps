class UsersController < ApplicationController
  before_filter :login_required
  before_filter :account_owner, :only => [:edit, :update]
  # render new.rhtml
  def new
    @user = User.new
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "User #{@user.login} created"
    else
      render :new
    end
  end

  def index
    @users=User.all(:order => :login)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Zmieniono hasło.'
        format.html { redirect_to(posts_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    id = params[:id]
    if id && user = User.find(id)
      begin
        user.safe_delete
        flash[:notice] = "User #{user.name} usunięty"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    respond_to do |format|
      format.html { redirect_to(users_path) }
      format.xml  { head :ok }
    end
  end

  private

  def account_owner
    unless current_user == User.find(params[:id])
      redirect_to users_path
      flash[:notice] = "Can't edit"
    end
  end
end
