class ContestantTribe < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :tribe
end
