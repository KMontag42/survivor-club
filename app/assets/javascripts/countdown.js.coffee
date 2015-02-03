$(document).ready ->
  $('.countdown').countdown(
    {
      compact: true,
      until: moment().add(2, 'minutes').toISOString()
    }
  )