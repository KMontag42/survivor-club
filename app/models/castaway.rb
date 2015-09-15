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

  def as_json(options={})
    {
        name: name,
        original_tribe: original_tribe.name,
        swapped_tribe: swapped_tribe.try(:name),
        merged_tribe: merged_tribe.try(:name),
        voted_out_number: voted_out_number,
        finish: finish,
        tribal_votes: tribal_votes,
        total_votes: total_votes,
        voted_out_episode: voted_out_episode.try(:name),
        season: season.name
    }
  end

  def tribe_for_season(season_id)
    original_tribe.name
  end
end
