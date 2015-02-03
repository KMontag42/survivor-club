$(document).ready ->
  countdown_elements = $('.countdown')
  round_display = $('.round-display')
  reset_countdown = ->
    countdown_elements.countdown('pause')
    countdown_elements.addClass 'animated pulse'

    setTimeout( ->
      current_round = parseInt round_display.data('round')
      round_display.html("Round #{current_round + 1}")
      round_display.data 'round', current_round + 1
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