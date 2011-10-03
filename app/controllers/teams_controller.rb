class TeamsController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  before_filter :team_played_match, :only => [:destroy]

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @matches = Match.with_team(@team)
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
      redirect_to teams_path, :notice => 'Team was successfully created.'
    else
      render :new
    end
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to teams_path, :notice => 'Team was successfully updated.'
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
    if Match.with_team(params[:id]).present?
      redirect_to leagues_path, :alert => 'Team played match, delete it first'
    end
  end
end
