# == Schema Information
#
# Table name: picks
#
#  id            :integer          not null, primary key
#  draft_id      :integer
#  contestant_id :integer
#  user_id       :integer
#  pick_type     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Pick < ActiveRecord::Base
  belongs_to :draft
  belongs_to :user
  belongs_to :contestant

  PICK_TYPE = %w(cash drinking)
end
