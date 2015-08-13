# == Schema Information
#
# Table name: castaways
#
#  id                   :integer          not null, primary key
#  season_id            :integer
#  original_tribe_id    :integer
#  swapped_tribe_id     :integer
#  merged_tribe_id      :integer
#  voted_out_episode_id :integer
#  finish               :integer
#  tribal_votes         :integer
#  total_votes          :integer
#  name                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  voted_out_number     :integer
#

class Castaway < ActiveRecord::Base
  belongs_to :season
  belongs_to :original_tribe, class_name: 'Tribe'
  belongs_to :swapped_tribe, class_name: 'Tribe'
  belongs_to :merged_tribe, class_name: 'Tribe'
  belongs_to :voted_out_episode, class_name: 'Episode'
end
