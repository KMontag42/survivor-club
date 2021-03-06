# == Schema Information
#
# Table name: contestants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  age        :integer
#  seasons_id :integer
#  from       :string(255)
#  job        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  hometown   :string(255)
#  image_url  :string(255)
#
# Indexes
#
#  index_contestants_on_seasons_id  (seasons_id)
#

class Contestant < ActiveRecord::Base
  has_many :contestants_users, class_name: "ContestantsUsers"
  has_many :contestants, through: :contestants_users

  has_many :contestants_seasons, class_name: "ContestantsSeasons"
  has_many :seasons, through: :contestants_seasons

  has_many :contestant_tribes
  has_many :tribes, through: :contestant_tribes

  has_many :picks
  has_many :vote_outs

  def self.create(params)
    _params = params
    seasons = _params.delete :seasons
    _contestant = super _params
    seasons = Season.find(seasons.reject(&:empty?))
    _contestant.seasons = seasons
    _contestant.save!
  end

  def update!(params)
    _params = params

    seasons = _params.delete :seasons
    tribes = _params.delete :tribes

    super _params

    seasons = Season.find(seasons.reject(&:empty?))
    tribes = Tribe.find(tribes.reject(&:empty?))

    self.seasons = self.seasons | seasons
    self.tribes = self.tribes | tribes

    self.save!
  end

  def tribe_for_season(season_id)
    tribes.find_by(season_id: season_id)
  end

  def in_tribe?(tribe_id)
    tribes.one?{ |x| x.id == tribe_id }
  end

  def vote_out_for_season(season_id)
    vote_outs.find_by(season_id: season_id)
  end
end
