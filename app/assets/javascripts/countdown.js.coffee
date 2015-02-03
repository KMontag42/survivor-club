$(document).ready ->
  reset_countdown = ->
    $('.countdown').countdown('pause')
    $('.countdown').addClass 'animated pulse'
    setTimeout( ->
      $('.countdown').removeClass 'animated pulse'
      $('.countdown').countdown('destroy')
      $('.countdown').countdown(
        {
          compact: true,
          until: moment().add(10, 'seconds').toDate(),
          onExpiry: reset_countdown
        }
      )
    , 3000)


  $('.countdown').countdown(
    {
      compact: true,
      until: moment().add(10, 'seconds').toDate(),
      onExpiry: reset_countdown
    }
  )