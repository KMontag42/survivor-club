class AdminSeasonsController < ApplicationController
  before_action :set_admin_season, only: [:show, :edit, :update, :destroy]

  # GET /admin_seasons
  # GET /admin_seasons.json
  def index
    @admin_seasons = Season.all
  end

  # GET /admin_seasons/1
  # GET /admin_seasons/1.json
  def show
  end

  # GET /admin_seasons/new
  def new
    @admin_season = Season.new
  end

  # GET /admin_seasons/1/edit
  def edit
  end

  # POST /admin_seasons
  # POST /admin_seasons.json
  def create
    @admin_season = Season.new(admin_season_params)

    respond_to do |format|
      if @admin_season.save
        format.html { redirect_to @admin_season, notice: ' season was successfully created.' }
        format.json { render :show, status: :created, location: @admin_season }
      else
        format.html { render :new }
        format.json { render json: @admin_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_seasons/1
  # PATCH/PUT /admin_seasons/1.json
  def update
    respond_to do |format|
      if @admin_season.update(admin_season_params)
        format.html { redirect_to @admin_season, notice: ' season was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_season }
      else
        format.html { render :edit }
        format.json { render json: @admin_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_seasons/1
  # DELETE /admin_seasons/1.json
  def destroy
    @admin_season.destroy
    respond_to do |format|
      format.html { redirect_to admin_seasons_url, notice: ' season was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_season
      @admin_season = Season.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_season_params
      params[:season]
    end
end
