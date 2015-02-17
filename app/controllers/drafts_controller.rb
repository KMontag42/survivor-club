class DraftsController < ApplicationController
  before_action :authenticate_user!

  def index
    # most recently made Draft
    @current_draft = Draft.last
    # previous Draft
    @last_draft = Draft.first unless Draft.first == Draft.last
  end

  def new
  end

  def show
    @draft = Draft.find(params[:id])
    if @draft.status == Draft::STATUS[2]
      redirect_to draft_picks_path(@draft)
    end
  end

  def edit
    @draft = Draft.find(params[:id])
  end

  def create
    Draft.create!(draft_params)
    redirect_to drafts_path
  end

  def update
    @draft = Draft.find(params[:id])
    @draft.update! draft_params
    redirect_to drafts_path(@draft)
  end

  def picks
    @cash_picks = Pick.where(draft_id: params[:draft_id],
                             user_id: current_user.id, pick_type: "cash")
    @drinking_picks = Pick.where(draft_id: params[:draft_id],
                             user_id: current_user.id, pick_type: "drinking")
  end

  private

  def draft_params
    params.require(:draft).permit(:season_id)
  end
end
