class TeamsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :team_played_match, :only=>[:destroy]

  def index
    @teams = Team.find(:all)
    @teams.delete_if {|team| team.name=='Pause'}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @teams }
    end
  end

  def show
    @team = Team.find(params[:id])
    @matches = Match.find(:all, :conditions=>['home_team_id=? OR visitor_team_id=?',@team.id, @team.id ])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team }
    end
  end

  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team }
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        flash[:notice] = 'Team was successfully created.'
        format.html { redirect_to teams_path }
        format.xml  { render :xml => @team, :status => :created, :location => @team }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        flash[:notice] = 'Team was successfully updated.'
        format.html { redirect_to teams_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to(teams_path) }
      format.xml  { head :ok }
    end
  end

  private

  def team_played_match
    matches = Match.find(:all, :conditions => ['home_team_id=? OR visitor_team_id=?', params[:id], params[:id] ])
    unless matches.empty?
      redirect_to leagues_path
      flash[:notice] = 'Team played match, delete it first'
    end
  end
end
