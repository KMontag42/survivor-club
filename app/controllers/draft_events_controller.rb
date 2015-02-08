class DraftEventsController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:active_player_index] = 0
    controller_store[:round_rotation] = [
      [3, Draft::ROUND_TYPE[0]],
      [-1, Draft::ROUND_TYPE[1]]
    ]
    controller_store[:current_round] = Draft::ROUND_TYPE[0].to_sym
    controller_store[:players] = User.all.sort
  end

  def active_player
    controller_store[:players][controller_store[:active_player_index]]
  end

  def next_player
    controller_store[:active_player_index] += 1
    controller_store[:active_player_index] =
        controller_store[:active_player_index] %
            controller_store[:players].length

    broadcast_message :next_player,
                      active_player,
                      namespace: :drafts
  end

  def join_draft
    picks = Pick.where(draft_id: message["draft_id"])

    message = {
      active_player: active_player,
      players: controller_store[:players].rotate(
          controller_store[:active_player_index]
      ),
      current_round: controller_store[:current_round],
      picks: picks.map { |x| x.contestant_id }
    }
    broadcast_message :join_draft, message, namespace: :drafts
  end

  def pick_contestant
    if active_player == current_user
      pick = Pick.new
      pick.draft_id = message["draft_id"]
      pick.contestant_id = message["contestant_id"]
      pick.pick_type = message["type"]

      _message = {
        pick: pick,
        contestant_name: pick.contestant.name,
        contestant_id: message["contestant_id"],
        success: true
      }

      if pick.save
        WebsocketRails.users[message["user_id"]].send_message :take_player,
                                                              _message,
                                                              namespace: :drafts

        broadcast_message :pick_contestant, _message, namespace: :drafts
        next_player
      end
    else
      # broadcast message to emitter that they are not the active player
      WebsocketRails.users[message["user_id"]].
          send_message :pick_contestant,
                       {
                         success: false,
                         message: "You are not the active player. " +
                             "Please wait your turn."
                       },
                       namespace: :drafts
    end
  end
end
