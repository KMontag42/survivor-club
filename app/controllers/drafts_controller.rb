class DraftsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_draft = Draft.last
    @last_draft = Draft.first
  end

  def new
  end

  def show
  end

  def edit
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

  private

  def draft_params
    params.require(:draft).permit(:season_id)
  end
end
