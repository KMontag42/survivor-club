class GameDayController < ApplicationController
  before_action :authenticate_user!

  def index
    @episode = Episode.where("air_date >= '#{Date.today}'").
                       sort { |a, b| a.number <=> b.number }.first
    @players = @episode.season.picks.map(&:user)
  end

end
