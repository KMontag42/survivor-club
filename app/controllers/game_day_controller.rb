class GameDayController < ApplicationController
  before_action :authenticate_user!

  def index
    # -6 hours to account for the time zone of the server
    @episode = Episode.where("air_date >= '#{Date.today - 6.hour}'").
                       sort { |a, b| a.number <=> b.number }.first
    @players = @episode.season.picks.map(&:user).uniq
  end

end
