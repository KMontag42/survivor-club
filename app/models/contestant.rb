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

  has_many :drafts_contestants, class_name: "DraftsContestants"
  has_many :contestants, through: :drafts_contestants

  def self.create(params)
    _params = params
    seasons = _params.delete :seasons
    _contestant = super _params
    seasons = Season.find(seasons.reject(&:empty?))
    _contestant.seasons = seasons
    _contestant.save!
  end

  def update(params)
    _params = params
    seasons = _params.delete :seasons
    super _params
    seasons = Season.find(seasons.reject(&:empty?))
    self.seasons = self.seasons | seasons
    self.save!
  end
end
