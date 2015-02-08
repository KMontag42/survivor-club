class DraftEventsController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:active_player_index] = 0
    controller_store[:round_rotation] = {
      Draft::ROUND_TYPE[0] => 3,
      Draft::ROUND_TYPE[1] => -1
    }
    controller_store[:round_number] = 1
    controller_store[:players] = User.all.sort
  end

  def current_round_type
    rotation = controller_store[:round_rotation]
    if rotation[Draft::ROUND_TYPE[0]] > 0
      Draft::ROUND_TYPE[0].to_s
    else
      Draft::ROUND_TYPE[1].to_s
    end
  end

  def next_round
    rotation = controller_store[:round_rotation]
    if current_round_type == Draft::ROUND_TYPE[0]
      rotation[Draft::ROUND_TYPE[0]] -= 1
      controller_store[:round_number] += 1
      _message = {
        round_number: controller_store[:round_number],
        round_type: Draft::ROUND_TYPE[0]
      }
    else
      controller_store[:round_number] += 1
      _message = {
        round_number: controller_store[:round_number],
        round_type: Draft::ROUND_TYPE[1]
      }
    end

    broadcast_message :next_round, _message, namespace: :drafts
  end

  def active_player
    controller_store[:players][controller_store[:active_player_index]]
  end

  def next_player
    controller_store[:active_player_index] += 1
    controller_store[:active_player_index] =
        controller_store[:active_player_index] %
            controller_store[:players].length

    if controller_store[:active_player_index] == 0
      next_round
    end
    broadcast_message :next_player,
                      active_player,
                      namespace: :drafts
  end

  def join_draft
    picks = Pick.where(draft_id: message["draft_id"])
    player_cash_picks = picks.select do |x|
      x.user_id == current_user.id && x.pick_type == Draft::ROUND_TYPE[0].to_s
    end
    player_cash_picks.map! do |x|
      Contestant.find(x.contestant_id)
    end
    player_drinking_picks = picks.select do |x|
      x.user_id == current_user.id && x.pick_type == Draft::ROUND_TYPE[1].to_s
    end
    player_drinking_picks.map! do |x|
      Contestant.find(x.contestant_id)
    end

    _message = {
      active_player: active_player,
      players: controller_store[:players].rotate(
          controller_store[:active_player_index]
      ),
      round_type: current_round_type,
      picks: picks.map { |x| x.contestant_id },
      player_cash_picks: player_cash_picks,
      player_drinking_picks: player_drinking_picks,
      round_number: controller_store[:round_number],
    }
    WebsocketRails.users[message["user_id"]].send_message :join_draft,
                                                          _message,
                                                          namespace: :drafts
  end

  def pick_contestant
    if active_player == current_user
      pick = Pick.new
      pick.user_id = active_player.id
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
