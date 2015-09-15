class DraftEventsController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:active_player_index] = 0
    controller_store[:round_rotation] = {
      Draft::ROUND_TYPE[0] => 2,
      Draft::ROUND_TYPE[1] => -1
    }
    controller_store[:round_number] = 1
    controller_store[:players] = []
    controller_store[:max_cash_picks] = 2
    controller_store[:max_picks] = -1
  end

  def current_round_type
    if controller_store[:round_rotation][Draft::ROUND_TYPE[0]] > 0
      Draft::ROUND_TYPE[0]
    else
      Draft::ROUND_TYPE[1]
    end
  end

  def next_round
    controller_store[:round_rotation][Draft::ROUND_TYPE[0]] -= 1

    if controller_store[:round_rotation][Draft::ROUND_TYPE[0]] == 0
      broadcast_message :round_type_changed, {}, namespace: :drafts
    end

    if current_round_type == Draft::ROUND_TYPE[0]
      controller_store[:round_number] += 1
      _message = {
        round_number: controller_store[:round_number],
        round_type: Draft::ROUND_TYPE[0].to_s.humanize
      }
    else
      controller_store[:round_number] += 1
      _message = {
        round_number: controller_store[:round_number],
        round_type: Draft::ROUND_TYPE[1].to_s.humanize
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
    draft = Draft.find_by(id: message["draft_id"])
    if draft && draft.status == Draft::STATUS[0]
      user = User.find(message['user_id'])

      unless controller_store[:players].include? user
        controller_store[:players] << user
      end

      _message = {
        success: true,
        active_player: active_player,
        players: controller_store[:players]
      }

      broadcast_message :join_draft, _message, namespace: :drafts

      WebsocketRails.users[1].send_message :ready_to_start, {},
                                           namespace: :drafts
    else
      _message = {
        success: false,
        message: "Draft Already Started"
      }
      WebsocketRails.users[message["user_id"]].send_message :join_draft,
                                                            _message,
                                                            namespace: :drafts
    end
  end

  def pick_contestant
    draft = Draft.find message["draft_id"]
    user = User.find message['user_id']
    if draft.status == Draft::STATUS[1]
      if active_player == user
        pick = Pick.new
        pick.user_id = active_player.id
        pick.draft_id = message["draft_id"]
        pick.contestant_id = message["contestant_id"]
        pick.pick_type = current_round_type.to_s

        _message = {
          pick: pick,
          contestant_name: pick.contestant.name,
          contestant_id: message["contestant_id"],
          success: true
        }

        if pick.save
          WebsocketRails.users[message["user_id"]].
            send_message :take_player, _message, namespace: :drafts

          broadcast_message :pick_contestant, _message, namespace: :drafts
          next_player
        else
          # broadcast message to emitter that there was an error
          WebsocketRails.users[message["user_id"]].
              send_message :pick_contestant,
                           {
                               success: false,
                               message: "There was an error. #{pick.errors}"
                           },
                           namespace: :drafts
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
    else
      p 'not active'
      # broadcast message to emitter that they are not the active player
      WebsocketRails.users[message["user_id"]].
        send_message :pick_contestant,
                     {
                       success: false,
                       message: "The draft has not started yet!. " +
                         "Please wait until it begins."
                     },
                     namespace: :drafts
    end

    if Pick.where(draft_id: draft).length == controller_store[:max_picks]
      end_draft
    end
  end

  def start_draft
    draft = Draft.find(message["draft_id"])
    draft.status = Draft::STATUS[1]
    draft.save!

    # 2 cash picks, and 4 drinking picks
    cash_picks = controller_store[:players].length * 2
    drinking_picks = controller_store[:players].length * 4
    controller_store[:max_picks] = cash_picks + drinking_picks

    # shuffle the players
    controller_store[:players].shuffle!

    broadcast_message :start_draft,
                      {
                        players: controller_store[:players]
                      },
                      namespace: :drafts
  end

  def end_draft
    draft = Draft.find(message["draft_id"])
    draft.status = Draft::STATUS[2]
    draft.save!

    broadcast_message :end_draft, {}, namespace: :drafts
  end
end
