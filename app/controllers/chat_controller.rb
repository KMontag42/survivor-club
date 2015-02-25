class ChatController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def send_chat
    cm = ChatMessage.create!(
      episode_id: message[:id],
      message: message[:message],
      user_id: message[:user_id]
    )
    broadcast_message :send_chat, message.merge({id: cm.id})
  end
end