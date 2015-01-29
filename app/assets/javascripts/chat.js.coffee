# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->
  dispatcher = new WebSocketRails('localhost:3000/websocket')
  dispatcher.bind 'send_chat', (data) ->
    console.log(data.message) # would output 'this is a message'
    $(".chat").append(
      "<p>#{data.message}</p>"
    )

  $('.send-chat').on 'click', (e)->
    e.preventDefault()
    target = $(e.target)
    console.log 'yo'
    dispatcher.trigger('send_chat', {message: $("#chat-line").val()})
