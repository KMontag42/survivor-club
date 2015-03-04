# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#  draft_id   :integer
#  image_url  :string(255)
#

class Season < ActiveRecord::Base
  has_many :episodes

  has_many :contestants_seasons, class_name: "ContestantsSeasons"
  has_many :contestants, through: :contestants_seasons

  has_many :picks
  has_many :vote_outs

  has_one :draft
end
