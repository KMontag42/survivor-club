# == Schema Information
#
# Table name: chat_messages
#
#  id         :integer          not null, primary key
#  message    :string(255)
#  user_id    :integer
#  episode_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class ChatMessage < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode

  def chat_format
    "#{user.name}: #{message}"
  end
end
