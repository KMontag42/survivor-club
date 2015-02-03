# == Schema Information
#
# Table name: contestant_tribes
#
#  id            :integer          not null, primary key
#  contestant_id :integer
#  tribe_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_contestant_tribes_on_contestant_id  (contestant_id)
#  index_contestant_tribes_on_tribe_id       (tribe_id)
#

class ContestantTribe < ActiveRecord::Base
  belongs_to :contestant
  belongs_to :tribe
end
