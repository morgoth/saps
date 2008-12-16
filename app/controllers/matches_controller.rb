class MatchesController < ApplicationController
  before_filter :login_required, :except => [:index]
  before_filter :get_league
  before_filter :update_empty_score_only, :only=> [:edit]
  def index
    #@matches = Match.all :order=>'round_id, hour'
    @matches = @league.matches
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
			format.rss
    end
  end

  # GET /matches/new
  # GET /matches/new.xml
  def new
    @match = Match.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.xml
  def create
    @match = Match.new(params[:match])
    respond_to do |format|
      if @match.save
        flash[:notice] = 'Match was successfully created.'
        format.html { redirect_to league_rounds_path(@league.id) }
        format.xml  { render :xml => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.xml
  def update
    @match = Match.find(params[:id])
    respond_to do |format|
      if @match.update_attributes(params[:match])
        flash[:notice] = 'Match was successfully updated.'
        format.html { redirect_to league_rounds_path(@league.id)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.xml
  def destroy
    @match = Match.find(params[:id])
    @match.destroy

    respond_to do |format|
      format.html { redirect_to league_rounds_path(@league.id) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def update_empty_score_only
    match = Match.find(params[:id])
    if !match.score.empty?
      flash[:notice] = "Update only available on empty score"
      redirect_to league_matches_path(@league.id)
    end
  end
  
  def get_league
    @league=League.find(params[:league_id])
  end
  
end
