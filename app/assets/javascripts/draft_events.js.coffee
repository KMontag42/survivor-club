$('body#draft').ready ->
  dispatcher = App.globals.dispatcher
  round_display = $('.round-display')
  contestants_panel = $('.contestants-panel')
  contestants_panel_heading = $('.contestants-panel .panel-heading')
  contestants_panel_body = $('.contestants-panel .panel-body')
  contestant_name = $('.contestant-name')
  draft_id = parseInt $(".draft-id").data('id')

  dispatcher.unbind 'drafts.join_draft'
  dispatcher.bind 'drafts.join_draft', (data) ->
    if data['success']
      active_player = data['active_player']
      players = data['players']

      new_player_name = active_player['first_name'] + ' ' +
          active_player['last_name']
      contestant_name.html(new_player_name)

      $("#draft_container").removeClass 'hidden'

      players_html = ""
      for player in players
        name_to_append = player['first_name'] + ' ' + player['last_name']

        players_html += "
          <p class='textfill' data-name='#{name_to_append}'>
            <span>#{name_to_append}</span>
          </p>
        "

      contestants_panel_body.html(players_html)
    else
      setTimeout(( ->
        swal data["message"]
      ), 1000)

  dispatcher.unbind 'drafts.next_player'
  dispatcher.bind 'drafts.next_player', (data) ->
    contestant_name = $('.contestant-name')
    current_player = contestants_panel_body.children('p').first()
    new_player = current_player.clone()

    current_player.addClass 'animated fadeOutUp'
    current_player.one App.globals.animation_event_callback, ->
      current_player.remove()
      next_player = contestants_panel_body.children('p').first()

      new_player.show()
      new_player.addClass 'animated fadeInUp'
      contestants_panel_body.append(new_player)

      new_player_name = data['first_name'] + ' ' + data['last_name']

      contestant_name.html(new_player_name)

  dispatcher.unbind 'drafts.pick_contestant'
  dispatcher.bind 'drafts.pick_contestant', (data) ->
    round_type = round_display.data 'round-type'
    if data['success'] == true && round_type == "Cash"
      contestant_id = data['contestant_id']
      contestant_tr = $("[data-id=#{contestant_id}]")
      contestant_tr.addClass('danger disabled')
    else if data['success'] == false
      swal 'Oh no!', data['message'], 'error'

  dispatcher.unbind 'drafts.take_player'
  dispatcher.bind 'drafts.take_player', (data) ->
    contestant_name = data['contestant_name']
    contestant_id = data['contestant_id']
    contestant_tr = $(".character-row[data-id=#{contestant_id}]")
    round_type = round_display.data 'round-type'
    contestant_tr.addClass('danger disabled')
    $(".draft-contestant[data-id=#{contestant_id}]").addClass 'disabled'

    if round_type == 'Cash'
      $('.money-picks').append "<p>#{contestant_name}</p>"
    else
      $('.drinking-picks').append "<p>#{contestant_name}</p>"

  dispatcher.unbind 'drafts.next_round'
  dispatcher.bind 'drafts.next_round', (data) ->
    round_display.data 'round-type', data['round_type']
    round_display.html("Round #{data['round_number']}")
    contestants_panel_heading.html(
      "Round #{data['round_number']} - #{data['round_type']}"
    )

  dispatcher.unbind 'drafts.start_draft'
  dispatcher.bind 'drafts.start_draft', (data) ->
    setTimeout(->
      swal 'IT BEGINS'
      players = data['players']
      players_html = ""
      for player in players
        name_to_append = player['first_name'] + ' ' + player['last_name']

        players_html += "
          <p class='textfill' data-name='#{name_to_append}'>
            <span>#{name_to_append}</span>
          </p>
        "

      contestants_panel_body.html(players_html)

      contestant_name = $('.contestant-name')
      active_player = players[0]
      contestant_name.html(active_player['first_name'] + ' ' +
        active_player['last_name'])

    , 1000)

  dispatcher.unbind 'drafts.ready_to_start'
  dispatcher.bind 'drafts.ready_to_start', (data) ->
    swal({
        title: 'Start the draft?',
        text: 'D R A F T BOYS',
        type: 'success'
        showCancelButton: true,
        confirmButtonText: 'Start'
      }, (isConfirm) ->
        if isConfirm
          dispatcher.trigger 'drafts.start_draft',
            {
              draft_id: draft_id
            }
    )

  dispatcher.unbind 'drafts.round_type_changed'
  dispatcher.bind 'drafts.round_type_changed', (data) ->
    $(".character-row").removeClass 'danger disabled'
    $(".draft-contestant").removeClass 'btn-success disabled danger'
    $(".draft-contestant").addClass 'btn-warning'

  dispatcher.unbind 'drafts.end_draft'
  dispatcher.bind 'drafts.end_draft', (data) ->
    $("#draft_container").addClass 'hidden'
    swal({
      title: "THAT'S IT!",
      message: "Press the button to see your picks!",
      type: "success",
      showCancelButton: false,
      confirmButtonText: "SHOW ME"
    }, ->
      window.location = window.location + '/picks'
    )