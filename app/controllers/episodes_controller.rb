class EpisodesController < ApplicationController

  def index
    @episodes = Episode.all
  end

  def show
    @episode = Episode.find(params[:id])
  end

  def edit
    @episode = Episode.find(params[:id])
  end

  def new
  end

  def create
    Episode.create!(episode_params)
    redirect_to episodes_path
  end

  def update
    @episode = Episode.find(params[:id])
    @episode.update! episode_params
    redirect_to episode_path(@episode)
  end

  private

  def episode_params
    params.require(:episode).permit(:number, :name, :season_id, :description)
  end
end