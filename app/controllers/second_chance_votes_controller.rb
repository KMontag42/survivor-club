class SecondChanceVotesController < ApplicationController

  def index
    redirect_to second_chance_votes_results_path
  end

  def create
    # error = false
    # # validate the votes, longhand but works shrug
    # flash[:danger] = []
    # if params[:males].try(:length) != 10
    #   flash[:danger] << 'Must select 10 Male Players'
    #   error = true
    # end
    # if params[:females].try(:length) != 10
    #   flash[:danger] << 'Must select 10 Female Players'
    #   error = true
    # end
    # if error
    #   flash[:danger] = flash[:danger].join(', ')
    #   return redirect_to new_second_chance_vote_path
    # end
    #
    # params[:males].each do |male|
    #   SecondChanceVote.create!(
    #     second_chance_potential_id: male,
    #     user_id: current_user.id
    #   )
    # end
    #
    # params[:females].each do |female|
    #   SecondChanceVote.create!(
    #       second_chance_potential_id: female,
    #       user_id: current_user.id
    #   )
    # end
    # flash[:success] = 'Votes Submitted Successfully!'
    # flash[:danger] = nil

    redirect_to second_chance_votes_results_path
  end

  def new
    if current_user.nil?
      flash[:danger] = 'You need to log in'
      return redirect_to new_user_session_path
    end
    @user = current_user
    unless @user.second_chance_votes.empty?
      flash[:danger] = 'You have already entered your picks!'
      redirect_to second_chance_votes_path
    end
  end

  def get_data
    voted_for = SecondChancePotential.all.select { |x|
      !SecondChanceVote.where(second_chance_potential_id: x).empty?
    }.collect { |x|
      [x.name, [SecondChanceVote.where(second_chance_potential_id: x).length]]
    }

    render json: voted_for.to_h, status: :ok
  end

  def results
  end
end
