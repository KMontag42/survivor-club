$(document).ready ->
  if $('body#draft').length > 0
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
        picks = data['picks']
        players = data['players']
        player_cash_picks = data['player_cash_picks']
        player_drinking_picks = data['player_drinking_picks']

        new_player_name = active_player['first_name'] + ' ' +
            active_player['last_name']
        contestant_name.html(new_player_name)

        for id in picks
          $(".character-row[data-id=#{id}]").addClass 'danger disabled'
          $(".draft-contestant[data-id=#{id}]").addClass 'disabled'

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

        money_picks_html = ''
        for cash_pick in player_cash_picks
          money_picks_html += "<p>#{cash_pick['name']}</p>"

        $('.money-picks').html money_picks_html

        drinking_picks_html = ''
        for drinking_pick in player_drinking_picks
          drinking_picks_html += "<p>#{drinking_pick['name']}</p>"

        $('.drinking-picks').html drinking_picks_html

        round_display.data 'round-type', data['round_type']
        round_display.data 'round', data['round_number']
        round_display.html("Round #{data['round_number']}")
      else
        setTimeout(( ->
          swal 'Already started brah'
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

      if round_type == 'Cash'
        $('.money-picks').append "<p>#{contestant_name}</p>"
      else
        $('.drinking-picks').append "<p>#{contestant_name}</p>"

    dispatcher.unbind 'drafts.next_round'
    dispatcher.bind 'drafts.next_round', (data) ->
      # this happens when the rounds rotate!
      if data['round_type'] != round_display.data('round-type')
        $(".character-row").removeClass 'danger disabled'
        $(".draft-contestant").removeClass 'btn-success disabled danger'
        $(".draft-contestant").addClass 'btn-warning'

      round_display.data 'round-type', data['round_type']
      round_display.html("Round #{data['round_number']}")
      contestants_panel_heading.html(
        "Round - #{data['round_number']} #{data['round_type']}"
      )

    dispatcher.unbind 'drafts.start_draft'
    dispatcher.bind 'drafts.start_draft', (data) ->
      setTimeout(->
        swal 'IT BEGINS'
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
          dispatcher.trigger 'drafts.start_draft',
            {
              draft_id: draft_id
            }
      )