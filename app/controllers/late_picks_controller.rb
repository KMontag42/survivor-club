class LatePicksController < ApplicationController
  def new
    contestants = Contestant.all
    user_picks = Pick.where(user_id: current_user.id).map(&:contestant)
    @contestants = contestants - user_picks
  end

  def create
    _params = late_pick_params

    if Pick.where(user_id: current_user.id).length < 6
      Pick.create!(
        draft_id: _params['draft_id'].to_i,
        user_id: current_user.id,
        season_id: _params[:season_id].to_i,
        contestant_id: _params[:contestant_id].to_i,
        pick_type: 'drinking'
      )
      flash[:success] = 'Picked character.'
    else
      flash[:error] = 'You already have enough picks.'
    end

    redirect_to new_late_pick_path
  end

  private

  def late_pick_params
    params.require(:pick).permit!
  end
end
