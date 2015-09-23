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
#  season_id     :integer
#

class Pick < ActiveRecord::Base
  belongs_to :draft
  belongs_to :user, primary_key: 'id'
  belongs_to :castaway, foreign_key: 'contestant_id', class_name: 'Castaway'
  belongs_to :season

  scope :voted_out, ->{joins(:castaway).where.not(castaways: {voted_out_number: nil})}

  PICK_TYPE = %w(cash drinking)
end
