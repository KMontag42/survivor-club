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

  private

  def draft_params
    params.require(:draft).permit(:season_id)
  end
end
