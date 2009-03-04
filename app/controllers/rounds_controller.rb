class RoundsController < ApplicationController
  before_filter :login_required, :except => [:index]

  def index
		@league = League.find(params[:league_id], :include => [ :rounds], :order => "rounds.date")
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rounds }
    end
  end

  def new
    @round = Round.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @round }
    end
  end

  def edit
    @round = Round.find(params[:id])
  end

  def create
    @round = Round.new(params[:round])
    @round.league_id = params[:league_id]

    respond_to do |format|
      if @round.save
        flash[:notice] = 'Round was successfully created.'
        format.html { redirect_to new_league_match_path(@round.league)}
        format.xml  { render :xml => @round, :status => :created, :location => @round }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @round = Round.find(params[:id])

    respond_to do |format|
      if @round.update_attributes(params[:round])
        flash[:notice] = 'Round was successfully updated.'
        format.html { redirect_to league_rounds_path(@round.league) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @round.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @round = Round.find(params[:id])
    @round.destroy

    respond_to do |format|
      format.html { redirect_to league_rounds_path(@round.league) }
      format.xml  { head :ok }
    end
  end
  
end
