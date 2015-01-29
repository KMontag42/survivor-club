# == Schema Information
#
# Table name: contestants_seasons
#
#  contestant_id :integer
#  season_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class ContestantsSeasons < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :season
end
