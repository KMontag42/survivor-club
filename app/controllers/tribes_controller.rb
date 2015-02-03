class TribesController < ApplicationController
  def index
  end

  def show
    @tribe = Tribe.find(params[:id])
  end

  def create
  end

  def update
  end
end
