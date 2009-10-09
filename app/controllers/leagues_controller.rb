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

    respond_to do |format|
      if @league.save
        flash[:notice] = 'League was successfully created.'
        format.html { redirect_to leagues_path }
        format.xml  { render :xml => @league, :status => :created, :location => @league }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @league = League.find(params[:id])
      respond_to do |format|
        if @league.update_attributes(params[:league])
          flash[:notice] = 'League was successfully updated.'
          format.html { redirect_to leagues_path }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
        end
      end
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    redirect_to leagues_path
  end

  def show
    league = @active_league || League.find_by_active(true)
    if league
      redirect_to league_rounds_path(league.id)
    else
      redirect_to leagues_path
    end
  end

end
