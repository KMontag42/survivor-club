class TribesController < ApplicationController
  def index
    @tribes = Tribe.all.sort
  end

  def show
    @tribe = Tribe.find(params[:id])
  end

  def new
    render layout: 'center_form'
  end

  def create
    Tribe.create(tribe_params)
    redirect_to tribes_path
  end

  def update
    @tribe = Tribe.find(params[:id])
    @tribe.update tribe_params
    redirect_to tribe_path(@tribe)
  end

  private

  def tribe_params
    params.require(:tribe).permit(:name, :color, :season)
  end
end
