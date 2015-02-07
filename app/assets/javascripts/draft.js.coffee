# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  if $('body#draft').length > 0
    dispatcher = App.globals.dispatcher
    round_display = $('.round-display')
    countdown_elements = $('.countdown')
    contestants_panel = $('.contestants-panel')
    contestant_name = $('.contestant-name')

    dispatcher.unbind 'drafts.join_draft'
    dispatcher.bind 'drafts.join_draft', (data) ->
      active_player = data['active_player']
      console.log active_player

      new_player_name = active_player['first_name'] + ' ' +
          active_player['last_name']
      contestant_name.html(new_player_name == ' ' || active_player['email'])
      $("#draft_container").removeClass 'hidden'

    swal({
      title: 'Ready to join the draft?',
      text: 'THE TIME IS NOW',
      type: 'success'
      showCancelButton: true,
      confirmButtonText: 'Join'
    }, (confirm) ->
      if confirm
        dispatcher.trigger 'drafts.join_draft'
      else
        window.location = '/'
    )
    $('body').on 'click', '.character-row', (event) ->
      target = $(event.target)
      contestant_id = target.parent().data 'id'
      $(".character-info:visible").addClass('hidden')
      $(".character-info[data-id=#{contestant_id}]").removeClass('hidden')

    $('body').on 'click', '.draft-contestant', (event) ->
      event.preventDefault()
      target = $(event.target)
      contestant_name = target.data 'name'
      contestant_id = target.data 'id'
      contestant_tr = $("[data-id=#{contestant_id}]")
      round_type = round_display.data 'round-type'

      contestant_tr.addClass('danger disabled')
      # this is where we make the event call,
      # and then a listener handles the visual update
      if round_type == 'money'
        $('.money-picks').append "<p>#{contestant_name}</p>"
      else
        $('.drinking-picks').append "<p>#{contestant_name}</p>"

      target.addClass('disabled')
      dispatcher.trigger 'drafts.next_player', {}
  #    else
  #      swal 'Whoops!', "You aren't the active player", 'error'

    dispatcher.unbind 'drafts.next_player'
    dispatcher.bind 'drafts.next_player', (data) ->
      contestant_name = $('.contestant-name')
      console.log data
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


#    countdown_elements.countdown('pause')
#    countdown_elements.addClass 'animated pulse'
#
#    setTimeout( ->
#      current_round = parseInt round_display.data('round')
#      round_display.html("Round #{current_round + 1}")
#      round_display.data 'round', current_round + 1
#
#      if current_round + 1 > 3
#        round_display.data 'round-type', 'drinking'
#        $('.draft-contestant').removeClass 'btn-success'
#        $('.draft-contestant').addClass 'btn-warning'
#
#      current_player = contestants_panel.children('p').first()
#      new_player = current_player.clone()
#
#      current_player.addClass 'animated fadeOutUp'
#      current_player.one App.globals.animation_event_callback, ->
#        current_player.remove()
#        next_player = contestants_panel.children('p').first()
#
#        new_player.show()
#        new_player.addClass 'animated fadeInUp'
#        contestants_panel.append(new_player)
#
#        contestant_name.html(next_player.data('name'))
#
#        countdown_elements.removeClass 'animated pulse'
#        countdown_elements.countdown('destroy')
#        countdown_elements.countdown(
#          {
#            compact: true,
#            until: moment().add(10, 'seconds').toDate(),
#            onExpiry: reset_countdown
#          }
#        )
#    , 3000)
