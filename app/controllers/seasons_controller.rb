class SeasonsController < ApplicationController

  def index
    @seasons = Season.all
  end

  def show
    @season = Season.find(params[:id])
  end

  def edit
    @season = Season.find(params[:id])
  end

  def new
  end

  def create
    Season.create!(season_params)
    redirect_to list_seasons_path
  end

  def update
    @season = Season.find(params[:id])
    @season.update! season_params
    redirect_to season_path(@season)
  end

  private

  def season_params
    params.require(:season).permit(:number, :name)
  end
end