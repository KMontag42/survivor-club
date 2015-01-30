class ContestantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contestants = Contestant.all
  end

  def show
    @contestant = Contestant.find(params[:id])
  end

  def edit
    @contestant = Contestant.find(params[:id])
  end

  def new
  end

  def create
    Contestant.create(contestant_params)
    redirect_to contestants_path
  end

  def update
    @contestant = Contestant.find(params[:id])
    @contestant.update contestant_params
    redirect_to contestant_path(@contestant)
  end

  private

  def contestant_params
    params.require(:contestant).permit(:name, :age, :job, :hometown, :seasons => [])
  end
end