class LeaguesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  def index
    @leagues = League.find(:all, :order => "created_at DESC")
  end

  def new
    @league = League.new
  end

  def edit
    @league = League.find(params[:id])
  end

  def create
    @league = League.new(params[:league])
    if @league.save
      flash[:notice] = 'League was successfully created.'
      redirect_to leagues_path
    else
      render :new
    end
  end

  def update
    @league = League.find(params[:id])
    if @league.update_attributes(params[:league])
      flash[:notice] = 'League was successfully updated.'
      redirect_to leagues_path
    else
      render :edit
    end
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    redirect_to leagues_path
  end
end
