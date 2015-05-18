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
        x.picks.where(pick_type: 'cash').length <= 0
      }
    else
      []
    end
  end

end
