position = 0

ready = () ->
  $('#right').click (e) ->
    position += 300
    $('#pages').animate({scrollLeft: position}, 800)
  $('#left').click (e) ->
    position -= 300
    $('#pages').animate({scrollLeft: position}, 800)
$(document).on 'turbolinks:load', ready
