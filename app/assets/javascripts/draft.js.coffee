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
    draft_id = parseInt $(".draft-id").data('id')

    swal({
      title: 'Ready to join the draft?',
      text: 'THE TIME IS NOW',
      type: 'success'
      showCancelButton: true,
      confirmButtonText: 'Join'
    }, (confirm) ->
      if confirm
        dispatcher.trigger 'drafts.join_draft', { draft_id: draft_id }
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
      contestant_id = parseInt target.data 'id'
      round_type = round_display.data 'round-type'

      dispatcher.trigger('drafts.pick_contestant', {
        user_id: App.globals.user.id,
        draft_id: draft_id,
        contestant_id: contestant_id,
        type: round_type
      })
