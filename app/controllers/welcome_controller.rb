class WelcomeController < ApplicationController
  def index
    @current_season = Season.last
  end
end
