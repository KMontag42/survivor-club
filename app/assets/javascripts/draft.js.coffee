# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('body').on 'click', '.character-row', (event) ->
    target = $(event.target)
    contestant_id = target.parent().data 'id'
    $(".character-info:visible").addClass('hidden')
    $(".character-info[data-id=#{contestant_id}]").removeClass('hidden')
