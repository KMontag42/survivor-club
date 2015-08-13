$("#rules").ready ->
  $('.rules-link').on 'click', (e) ->
    target = $(e.target)
    $('.active-rule').addClass('hidden').removeClass('active-rule')
    $(target[0].hash).removeClass('hidden').addClass('active-rule')
