class LiveController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def contestant_clicked
    new_message = {:message => 'contestant clicked'}
    WebsocketRails.users[1].send_message(:contestant_clicked, {:message => 'you\'ve got an upvote '})
    broadcast_message :contestant_clicked, new_message
  end

  def player_clicked
    new_message = {:message => 'player clicked'}
    broadcast_message :player_clicked, new_message
  end
end