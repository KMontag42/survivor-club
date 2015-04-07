class WelcomeController < ApplicationController
  def index
    @show_spoilers = current_user.try(:show_spoilers)
    @recent_vote_outs = VoteOut.all.reverse_order[0..2]
  end
end
