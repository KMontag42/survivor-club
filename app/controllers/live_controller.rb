class LiveController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def contestant_clicked
    new_message = {:message => 'contestant clicked'}
    broadcast_message :contestant_clicked, new_message
  end

  def player_clicked
    new_message = {:message => 'player clicked'}
    broadcast_message :player_clicked, new_message
  end
end