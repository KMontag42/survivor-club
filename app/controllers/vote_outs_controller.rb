class VoteOutsController < ApplicationController
  def index
    @vote_outs = VoteOut.all
  end

  def show
    @vote_out = VoteOut.find(params[:id])
  end

  def new
    @vote_out = VoteOut.new
    @season = Season.find(1)
  end

  def create
    @vote_out = VoteOut.create!(vote_out_params)

    redirect_to vote_out_path(@vote_out)
  end

  private

  def vote_out_params
    params.require(:vote_out).permit(:season_id, :episode_id, :contestant_id)
  end
end
