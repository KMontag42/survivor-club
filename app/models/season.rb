# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Season < ActiveRecord::Base
  has_many :episodes
end
