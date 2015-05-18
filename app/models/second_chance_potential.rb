# == Schema Information
#
# Table name: second_chance_potentials
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  photo      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  gender     :string(255)
#

class SecondChancePotential < ActiveRecord::Base

  has_many :second_chance_votes

end
