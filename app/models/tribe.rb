# == Schema Information
#
# Table name: tribes
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  color      :string(255)
#  season_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_tribes_on_season_id  (season_id)
#

class Tribe < ActiveRecord::Base
  belongs_to :season

  has_many :contestant_tribes
  has_many :contestants, through: :contestant_tribes
end
