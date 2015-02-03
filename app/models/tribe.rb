class Tribe < ActiveRecord::Base
  belongs_to :season

  has_many :contestant_tribes
  has_many :contestants, through: :contestant_tribes
end
