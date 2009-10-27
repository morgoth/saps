class PlayersController < ApplicationController
  before_filter :login_required, :except => [:index]

  def index
    @players = Player.all
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
      flash[:notice] = 'Player was successfully created.'
      redirect_to players_path
    else
      render :new
    end
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      flash[:notice] = 'Player was successfully updated.'
      redirect_to players_path
    else
      render :edit
    end
  end

  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    flash[:notice] = 'Player was successfully updated.'
    redirect_to players_path
  end
end
