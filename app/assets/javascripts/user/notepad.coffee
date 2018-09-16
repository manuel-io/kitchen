# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

array = []

ready = () ->
  notepad = $('#notepad')
  list = $('#notepad #list')
  element = $('#notepad #list p')
  input = $('#notepad #input')

  list.empty()

  input.keydown (e) ->
    if (e.keyCode == 13)
      e.preventDefault()

  input.keyup (e) ->
    if (e.keyCode == 13)
      e.preventDefault()
      list_element = element.clone()[0]
      value = input.val()
      array.push value
      list.append $(list_element).html(value)
      
      $('#notepad input[name=query]').val array.join(',')
      input.val('')
  
$(document).on 'turbolinks:load', ready
