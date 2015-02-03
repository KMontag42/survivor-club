$(document).on 'ready page:load', ->
  $('.countdown').countdown({compact: true, until: moment().add(2, 'minutes').toISOString()})