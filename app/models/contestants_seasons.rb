class ContestantsSeasons < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :season
end