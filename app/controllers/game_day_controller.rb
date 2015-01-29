class GameDayController < ApplicationController
  before_action :authenticate_user!

  def index
    @episode = Episode.where("air_date >= '#{Date.today}'").first
  end

end
