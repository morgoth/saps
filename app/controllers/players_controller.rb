class PlayersController < ApplicationController
  before_filter :login_required, :except => [:index]

  def index
    @active_players = Player.active
    @not_active_players = Player.not_active
  end

  def new
    @player = Player.new
  end

  def edit
    @player = Player.find(params[:id])
  end

  def create
    @player = Player.new(params[:player])
    if @player.save
      redirect_to players_path, :notice => 'Player was successfully created.'
    else
      render :new
    end
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      redirect_to players_path, :notice => 'Player was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    redirect_to players_path, :notice => 'Player was successfully updated.'
  end
end
