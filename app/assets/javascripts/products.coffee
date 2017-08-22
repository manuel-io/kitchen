# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = () ->
  $('#product_liquid_true').click () ->  $('.unit').text 'ml'
  $('#product_liquid_false').click () ->  $('.unit').text 'g'

  $.each $('.nutritional'), (v, w) ->
    $.each $(w).find('td'), (x, y) ->
      $(w).css("visibility", "hidden") if $(y).text() == ""
      $(w).css("display", "none") if $(y).text() == "" || $(y).text() == "0"

  $.each $('.vitamin'), (v, w) ->
    $.each $(w).find('td'), (x, y) ->
      $(w).css("visibility", "hidden") if $(y).text() == ""
      $(w).css("display", "none") if $(y).text() == "" || $(y).text() == "0"

  $.each $('.mineral'), (v, w) ->
    $.each $(w).find('td'), (x, y) ->
      $(w).css("visibility", "hidden") if $(y).text() == ""
      $(w).css("display", "none") if $(y).text() == "" || $(y).text() == "0"
      
$(document).on 'turbolinks:load', ready
