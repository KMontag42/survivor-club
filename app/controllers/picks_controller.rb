class PicksController < ActiveRecord::Base
  before_filter :authenticate_user!

  def index
    @picks = Pick.all
    respond_to do |format|
      format.html
      format.json { render json: @picks }
    end
  end
end