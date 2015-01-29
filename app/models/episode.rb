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
#

class Episode < ActiveRecord::Base
  belongs_to :season
end
