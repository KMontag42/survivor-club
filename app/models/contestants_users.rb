# == Schema Information
#
# Table name: contestants_users
#
#  id            :integer          not null, primary key
#  contestant_id :integer
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#
class ContestantsUsers < ActiveRecord::Base
end
