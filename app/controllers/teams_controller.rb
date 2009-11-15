class TeamsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :team_played_match, :only=>[:destroy]

  def index
    @teams = Team.find(:all)
    @teams.delete_if { |team| team.name == 'Pause' }
  end

  def show
    @team = Team.find(params[:id])
    @matches = Match.find(:all, :conditions => ['home_team_id=? OR visitor_team_id=?',@team.id, @team.id ])
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = 'Team was successfully created.'
      redirect_to teams_path
    else
      render :new
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = 'Team was successfully updated.'
      redirect_to teams_path
    else
      render :edit
    end
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to teams_path
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
