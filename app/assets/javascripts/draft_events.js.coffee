$(document).ready ->
  if $('body#draft').length > 0
    dispatcher = App.globals.dispatcher
    round_display = $('.round-display')
    contestants_panel = $('.contestants-panel')
    contestant_name = $('.contestant-name')

    dispatcher.unbind 'drafts.join_draft'
    dispatcher.bind 'drafts.join_draft', (data) ->
      console.log data
      active_player = data['active_player']
      picks = data['picks']

      new_player_name = active_player['first_name'] + ' ' +
          active_player['last_name']
      contestant_name.html(new_player_name == ' ' || active_player['email'])

      for id in picks
        $(".character-row[data-id=#{id}]").addClass 'danger disabled'
        $(".draft-contestant[data-id=#{id}]").addClass 'disabled'

      $("#draft_container").removeClass 'hidden'


    dispatcher.unbind 'drafts.next_player'
    dispatcher.bind 'drafts.next_player', (data) ->
      contestant_name = $('.contestant-name')
      current_player = contestants_panel.children('p').first()
      new_player = current_player.clone()

      current_player.addClass 'animated fadeOutUp'
      current_player.one App.globals.animation_event_callback, ->
        current_player.remove()
        next_player = contestants_panel.children('p').first()

        new_player.show()
        new_player.addClass 'animated fadeInUp'
        contestants_panel.append(new_player)

        new_player_name = (data['first_name'] != null) ?
            data['first_name'] + ' ' + data['last_name'] || data['email']

        contestant_name.html(new_player_name)

    dispatcher.unbind 'drafts.pick_contestant'
    dispatcher.bind 'drafts.pick_contestant', (data) ->
      if data['success'] == true
        contestant_name = data['contestant_name']
        contestant_id = data['contestant_id']
        contestant_tr = $("[data-id=#{contestant_id}]")
        round_type = round_display.data 'round-type'
        contestant_tr.addClass('danger disabled')
      else
        swal 'Oh no!', data['message'], 'error'

    dispatcher.unbind 'drafts.take_player'
    dispatcher.bind 'drafts.take_player', (data) ->
      contestant_name = data['contestant_name']
      contestant_id = data['contestant_id']
      contestant_tr = $(".character-row[data-id=#{contestant_id}]")
      round_type = round_display.data 'round-type'
      contestant_tr.addClass('danger disabled')
      $(".draft-contestant[data-id=#{contestant_id}]").addClass 'disabled'

      if round_type == 'cash'
        $('.money-picks').append "<p>#{contestant_name}</p>"
      else
        $('.drinking-picks').append "<p>#{contestant_name}</p>"