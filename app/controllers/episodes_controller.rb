class EpisodesController < ApplicationController
  # before_action :authenticate_user!

  def index
    @episodes = Episode.all
    @episodes = @episodes.where(season_id: params[:season]) if params[:season]
    respond_to do |format|
      format.html
      format.json { render json: @episodes }
    end
  end

  def show
    @episode = Episode.find(params[:id])
  end

  def edit
    @episode = Episode.find(params[:id])
    render layout: 'center_form'
  end

  def new
    render layout: 'center_form'
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
    params.require(:episode).permit(:number, :name, :air_date,
                                    :season_id, :description)
  end
end