class AchievementsController < ApplicationController
  before_filter :login_required, :except => [:index]

  def index
    @achievements = Achievement.all
  end

  def new
    @achievement = Achievement.new
  end

  def edit
    @achievement = Achievement.find(params[:id])
  end

  def create
    @achievement = Achievement.new(params[:achievement])
    if @achievement.save
      redirect_to achievements_path, :notice => "Achievement created"
    else
      render :new
    end
  end

  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update_attributes(params[:achievement])
      redirect_to achievements_path, :notice => "Achievement updated"
    else
      render :edit
    end
  end

  def destroy
    @achievement = Achievement.find(params[:id])
    @achievement.destroy
    redirect_to achievements_path, :notice => "Achievement destroyed"
  end
end
