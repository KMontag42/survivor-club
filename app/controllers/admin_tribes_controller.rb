class AdminTribesController < ApplicationController
  before_action :set_admin_tribe, only: [:show, :edit, :update, :destroy]

  # GET /admin_tribes
  # GET /admin_tribes.json
  def index
    @admin_tribes = Tribe.all
  end

  # GET /admin_tribes/1
  # GET /admin_tribes/1.json
  def show
  end

  # GET /admin_tribes/new
  def new
    @admin_tribe = Tribe.new
  end

  # GET /admin_tribes/1/edit
  def edit
  end

  # POST /admin_tribes
  # POST /admin_tribes.json
  def create
    @admin_tribe = Tribe.new(admin_tribe_params)

    respond_to do |format|
      if @admin_tribe.save
        format.html { redirect_to @admin_tribe, notice: ' tribe was successfully created.' }
        format.json { render :show, status: :created, location: @admin_tribe }
      else
        format.html { render :new }
        format.json { render json: @admin_tribe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_tribes/1
  # PATCH/PUT /admin_tribes/1.json
  def update
    respond_to do |format|
      if @admin_tribe.update(admin_tribe_params)
        format.html { redirect_to @admin_tribe, notice: ' tribe was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_tribe }
      else
        format.html { render :edit }
        format.json { render json: @admin_tribe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_tribes/1
  # DELETE /admin_tribes/1.json
  def destroy
    @admin_tribe.destroy
    respond_to do |format|
      format.html { redirect_to admin_tribes_url, notice: ' tribe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_tribe
      @admin_tribe = Tribe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_tribe_params
      params[:admin_tribe]
    end
end
