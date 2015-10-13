class AdminEpisodesController < ApplicationController
  before_action :set_admin_episode, only: [:show, :edit, :update, :destroy]

  # GET /admin_episodes
  # GET /admin_episodes.json
  def index
    @admin_episodes = Episode.all
  end

  # GET /admin_episodes/1
  # GET /admin_episodes/1.json
  def show
  end

  # GET /admin_episodes/new
  def new
    @admin_episode = Episode.new
  end

  # GET /admin_episodes/1/edit
  def edit
  end

  # POST /admin_episodes
  # POST /admin_episodes.json
  def create
    @admin_episode = Episode.new(admin_episode_params)

    respond_to do |format|
      if @admin_episode.save
        format.html { redirect_to @admin_episode, notice: 'Admin episode was successfully created.' }
        format.json { render :show, status: :created, location: @admin_episode }
      else
        format.html { render :new }
        format.json { render json: @admin_episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_episodes/1
  # PATCH/PUT /admin_episodes/1.json
  def update
    respond_to do |format|
      if @admin_episode.update(admin_episode_params)
        format.html { redirect_to @admin_episode, notice: 'Admin episode was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_episode }
      else
        format.html { render :edit }
        format.json { render json: @admin_episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_episodes/1
  # DELETE /admin_episodes/1.json
  def destroy
    @admin_episode.destroy
    respond_to do |format|
      format.html { redirect_to admin_episodes_url, notice: 'Admin episode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_episode
      @admin_episode = Episode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_episode_params
      params.require(:episode).permit(:number, :name, :air_date,
                                      :season_id, :description)
    end
end
