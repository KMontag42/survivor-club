# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  if $("body#game_day").length > 0
    dispatcher = new WebSocketRails('localhost:3000/websocket')

    dispatcher.bind 'contestant_clicked', (data) ->
      console.log data

    dispatcher.bind 'player_clicked', (data) ->
      console.log data

    $('.contestant').on 'click', (event) ->
      dispatcher.trigger 'contestant_clicked'

    $(".player").on 'click', (event) ->
      dispatcher.trigger 'player_clicked'