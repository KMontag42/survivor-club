class WelcomeController < ApplicationController
  layout 'nonavbar'
  def index
    @show_spoilers = current_user.try(:show_spoilers)
    @recent_vote_outs = VoteOut.all.reverse_order[0..2]

    if current_user
      redirect_to game_day_path
    end
  end
end
