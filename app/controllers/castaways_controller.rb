class CastawaysController < ApplicationController
  def index
    @castaways = Castaway.all
    respond_to do |format|
      format.html
      format.json { render json: @castaways }
    end
  end

  def show
    @castaway = Castaway.find(params[:id])
  end

  def edit
    @castaway = Castaway.find(params[:id])
  end

  def create
    @castaway = Castaway.new
  end

  def update
    @castaway = Castaway.find(params[:id])
  end
end
