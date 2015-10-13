class AdminCastawaysController < ApplicationController
  before_action :set_admin_castaway, only: [:show, :edit, :update, :destroy]

  # GET /admin_castaways
  # GET /admin_castaways.json
  def index
    @admin_castaways = Castaway.all
  end

  # GET /admin_castaways/1
  # GET /admin_castaways/1.json
  def show
  end

  # GET /admin_castaways/new
  def new
    @admin_castaway = Castaway.new
  end

  # GET /admin_castaways/1/edit
  def edit
  end

  # POST /admin_castaways
  # POST /admin_castaways.json
  def create
    @admin_castaway = Castaway.new(admin_castaway_params)

    respond_to do |format|
      if @admin_castaway.save
        format.html { redirect_to admin_castaways_path, notice: 'castaway was successfully created.' }
        format.json { render :show, status: :created, location: @admin_castaway }
      else
        format.html { render :new }
        format.json { render json: @admin_castaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_castaways/1
  # PATCH/PUT /admin_castaways/1.json
  def update
    respond_to do |format|
      if @admin_castaway.update(admin_castaway_params)
        format.html { redirect_to admin_castaways_path, notice: 'castaway was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_castaway }
      else
        format.html { render :edit }
        format.json { render json: @admin_castaway.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_castaways/1
  # DELETE /admin_castaways/1.json
  def destroy
    @admin_castaway.destroy
    respond_to do |format|
      format.html { redirect_to admin_castaways_url, notice: ' castaway was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_castaway
      @admin_castaway = Castaway.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_castaway_params
      params.require(:castaway).permit(:id, :name, :season_id,
                                       :original_tribe_id, :swapped_tribe_id,
                                       :merged_tribe_id, :voted_out_episode_id,
                                       :picture_url)
    end
end
