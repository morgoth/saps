class MatchesController < ApplicationController
  before_filter :login_required, :except => [:index]
  before_filter :get_league
  before_filter :update_empty_score_only, :only=> [:edit, :update]

  def index
    @matches = @league.matches
  end

  def new
    @match = @league.matches.build
  end

  def edit
    @match = @league.matches.find(params[:id])
  end

  def create
    @match = @league.matches.build(params[:match])
    if @match.save
      flash[:notice] = 'Match was successfully created.'
      redirect_to league_rounds_path @league
    else
      render :new
    end
  end

  def update
    @match = @league.matches.find(params[:id])
    if @match.update_attributes(params[:match])
      flash[:notice] = 'Match was successfully updated.'
      redirect_to league_rounds_path(@league)
    else
      render :edit
    end
  end

  def destroy
    @match = @league.matches.find(params[:id])
    @match.destroy
    redirect_to league_rounds_path(@league)
  end

  private

  def update_empty_score_only
    match = @league.matches.find(params[:id])
    unless match.score.empty?
      flash[:notice] = "Update only available on empty score"
      redirect_to league_matches_path(@league)
    end
  end

  def get_league
    @league = League.find(params[:league_id])
  end
end
