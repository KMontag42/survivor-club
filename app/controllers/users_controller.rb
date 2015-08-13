class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    # @user = User.find(params[:id])
    # @cash_picks = @user.picks.where(pick_type: 'cash')
    # @drinking_picks = @user.picks.where(pick_type: 'drinking')
  end

  def edit
    @user = User.find(params[:id])

    render layout: 'center_form'
  end

  def update
    user = User.find(params[:id])
    user.update! user_params

    redirect_to user_path(user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :show_spoilers)
  end
end
