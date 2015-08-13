# == Schema Information
#
# Table name: episodes
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  number      :integer
#  season_id   :integer
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  air_date    :date
#

class Episode < ActiveRecord::Base

  belongs_to :season
  has_many :chat_messages
  has_one :vote_out

  def knocked_out
    if vote_out
      User.who_picked(vote_out.contestant).select { |x|
        # get the users picks
        x.picks.where(pick_type: 'cash').select { |y|
          # check to see if voted out
          y.contestant.vote_outs.length >= 1
        }.length == 2
      }
    else
      []
    end
  end

  def to_json
    {
        name: name,
        won_reward: 'Kyle',
        won_immunity: 'Kyle',
        voted_out: 'Robby',
        season: season.id
    }
  end
end
