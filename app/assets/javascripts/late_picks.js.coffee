# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  if $('body#late-picks').length > 0
    container = $('#late-picks-container')
    container.isotope {
      'layoutMode': 'masonry',
      'itemSelector': '.item'
    }
