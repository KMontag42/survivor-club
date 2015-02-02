# == Schema Information
#
# Table name: drafts_contestants
#
#  id            :integer          not null, primary key
#  draft_id      :integer
#  contestant_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class DraftsContestants < ActiveRecord::Base
  belongs_to :draft
  belongs_to :contestant
end
