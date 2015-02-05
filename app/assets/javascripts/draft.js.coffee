# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  round_display = $('.round-display')
  countdown_elements = $('.countdown')
  contestants_panel = $('.contestants-panel')
  contestant_name = $('.contestant-name')

  $('body').on 'click', '.character-row', (event) ->
    target = $(event.target)
    contestant_id = target.parent().data 'id'
    $(".character-info:visible").addClass('hidden')
    $(".character-info[data-id=#{contestant_id}]").removeClass('hidden')

  $('body').on 'click', '.draft-contestant', (event) ->
    event.preventDefault()
    target = $(event.target)
    contestant_name = target.data 'name'
    round_type = round_display.data 'round-type'
    # this is where we make the event call,
    # and then a listener handles the visual update
    if round_type == 'money'
      $('.money-picks').append "<p>#{contestant_name}</p>"
    else
      $('.drinking-picks').append "<p>#{contestant_name}</p>"

    target.addClass('disabled')
#    else
#      swal 'Whoops!', "You aren't the active player", 'error'

  reset_countdown = ->
    countdown_elements.countdown('pause')
    countdown_elements.addClass 'animated pulse'

    setTimeout( ->
      current_round = parseInt round_display.data('round')
      round_display.html("Round #{current_round + 1}")
      round_display.data 'round', current_round + 1

      if current_round + 1 > 3
        round_display.data 'round-type', 'drinking'
        $('.draft-contestant').removeClass 'btn-success'
        $('.draft-contestant').addClass 'btn-warning'

      current_player = contestants_panel.children('p').first()
      new_player = current_player.clone()

      current_player.addClass 'animated fadeOutUp'
      current_player.one App.globals.animation_event_callback, ->
        current_player.remove()
        next_player = contestants_panel.children('p').first()

        new_player.show()
        new_player.addClass 'animated fadeInUp'
        contestants_panel.append(new_player)

        contestant_name.html(next_player.data('name'))

        countdown_elements.removeClass 'animated pulse'
        countdown_elements.countdown('destroy')
        countdown_elements.countdown(
          {
            compact: true,
            until: moment().add(10, 'seconds').toDate(),
            onExpiry: reset_countdown
          }
        )
    , 3000)

  countdown_elements.countdown(
    {
      compact: true,
      until: moment().add(10, 'seconds').toDate(),
      onExpiry: reset_countdown
    }
  )