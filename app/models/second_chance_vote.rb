# == Schema Information
#
# Table name: second_chance_votes
#
#  id                         :integer          not null, primary key
#  second_chance_potential_id :integer
#  user_id                    :integer
#  created_at                 :datetime
#  updated_at                 :datetime
#

class SecondChanceVote < ActiveRecord::Base

  belongs_to :second_chance_potential
  belongs_to :user

end
