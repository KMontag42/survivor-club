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

  def new
    render layout: 'center_form'
  end

  def edit
    @castaway = Castaway.find(params[:id])
  end

  def create
    @castaway = Castaway.new(allowed_params)
    if @castaway.save
      flash[:success] = 'Castaway created!'
      redirect_to admin_path
    else
      flash[:danger] = @castaway.errors
      respond_with @castaway do |format|
        format.any
      end
    end
  end

  def update
    @castaway = Castaway.find(params[:id])
    if @castaway.update(allowed_params)
      flash[:success] = 'Castaway updated!'
      redirect_to admin_path
    else
      flash[:danger] = @castaway.errors
      respond_with @castaway do |format|
        format.any
      end
    end
  end

  protected

  def allowed_params
    params.require(:castaway).permit(:id, :name, :season_id, :original_tribe_id)
  end
end
