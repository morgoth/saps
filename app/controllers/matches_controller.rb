class MatchesController < ApplicationController
  before_filter :login_required, :except => [:index]

  def index
    @matches = Match.recent.with_score
  end

  def new
    @match = league.matches.build
  end

  def edit
    @match = league.matches.find(params[:id])
  end

  def create
    @match = league.matches.build(params[:match])
    if @match.save
      redirect_to league_rounds_path(league), :notice => 'Match was successfully created.'
    else
      render :new
    end
  end

  # TODO: investigate readonly
  def update
    @match = league.matches.find(params[:id], :readonly => false)
    if @match.update_attributes(params[:match])
      redirect_to league_rounds_path(league), :notice => 'Match was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @match = league.matches.find(params[:id])
    @match.destroy
    redirect_to league_rounds_path(league), :notice => "Match was destroyed"
  end

  private

  def league
    @league ||= League.find(params[:league_id])
  end
end
