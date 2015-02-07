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
    controller_store[:active_player_index] = controller_store[:active_player_index] % controller_store[:players].length
    puts controller_store[:active_player_index]
    broadcast_message :next_player,
      active_player,
      namespace: :drafts

  end

  def join_draft
    broadcast_message :join_draft, {
        active_player: active_player,
        current_round: controller_store[:current_round]
      },
      namespace: :drafts
  end
end