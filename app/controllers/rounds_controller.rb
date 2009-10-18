class RoundsController < ApplicationController
  before_filter :login_required, :except => [:index]
  before_filter :fetch_league

  def index
    @rounds = @league.rounds
  end

  def new
    @round = @league.rounds.build
  end

  def edit
    @round = @league.rounds.find(params[:id])
  end

  def create
    @round = @league.rounds.build(params[:round])
    if @round.save
      flash[:notice] = 'Round was successfully created.'
      redirect_to new_league_match_path(@league)
    else
      render :new
    end
  end

  def update
    @round = @league.rounds.find(params[:id])
    if @round.update_attributes(params[:round])
      flash[:notice] = 'Round was successfully updated.'
      redirect_to league_rounds_path(@league)
    else
      render :edit
    end
  end

  def destroy
    @round = @league.rounds.find(params[:id])
    @round.destroy
    redirect_to league_rounds_path(@league)
  end

  private

  def fetch_league
    @league = League.find(params[:league_id])
  end
end
