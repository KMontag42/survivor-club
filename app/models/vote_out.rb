# == Schema Information
#
# Table name: vote_outs
#
#  id            :integer          not null, primary key
#  season_id     :integer
#  contestant_id :integer
#  episode_id    :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class VoteOut < ActiveRecord::Base
  belongs_to :season
  belongs_to :contestant
  belongs_to :episode
end
