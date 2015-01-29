class ChatController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def send_chat
    new_message = {:message => message[:message]}
    send_message :send_chat, new_message
  end
end