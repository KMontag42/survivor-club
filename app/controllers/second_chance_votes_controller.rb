class SecondChanceVotesController < ApplicationController

  def index
  end

  def create
    error = false
    # validate the votes, longhand but works shrug
    flash[:danger] = []
    if params[:males].try(:length) != 10
      flash[:danger] << 'Must select 10 Male Players'
      error = true
    end
    if params[:females].try(:length) != 10
      flash[:danger] << 'Must select 10 Female Players'
      error = true
    end
    if error
      flash[:danger] = flash[:danger].join(', ')
      return redirect_to new_second_chance_vote_path
    end

    params[:males].each do |male|
      SecondChanceVote.create!(
        second_chance_potential_id: male,
        user_id: current_user.id
      )
    end

    params[:females].each do |female|
      SecondChanceVote.create!(
          second_chance_potential_id: female,
          user_id: current_user.id
      )
    end
    flash[:success] = 'Votes Submitted Successfully!'
    flash[:danger] = nil

    redirect_to second_chance_votes_path
  end

  def new
    @user = current_user
    unless @user.second_chance_votes.empty?
      flash[:danger] = 'You have already entered your picks!'
      redirect_to second_chance_votes_path
    end
  end

end
