class ChatController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
    controller_store[:online] = []
  end

  def send_chat
    cm = ChatMessage.create!(
      episode_id: message[:id],
      message: message[:message],
      user_id: message[:user_id]
    )
    broadcast_message :send_chat, message.merge({id: cm.id})
  end

  def user_joined
    controller_store[:online] << current_user.first_name + ' ' + current_user.last_name
    controller_store[:online].uniq!
    broadcast_message :user_joined, {online_users: controller_store[:online]}
  end

  def user_left
    controller_store[:online].delete current_user.first_name + ' ' + current_user.last_name
    broadcast_message :user_left, {online_users: controller_store[:online]}
  end
end