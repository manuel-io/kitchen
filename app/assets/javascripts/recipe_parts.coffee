ready = () ->
  $('#recipe_part_child_id').change () ->
    $('#recipe_part_scale').val('1')
  $('#recipe_part_part').change () ->
    if $('#recipe_part_part option:selected').val() == 'components'
      $('#connection').css('display', 'none')
      $('#amount').css('display', 'none')
      $('#guidance').css('display', 'block')
    if $('#recipe_part_part option:selected').val() == 'connections'
      $('#connection').css('display', 'block')
      $('#amount').css('display', 'block')
      $('#guidance').css('display', 'none')

$(document).on 'turbolinks:load', () ->
  $('#guidance').css('display', 'none')
  $('#recipe_part_scale').val('1')
  ready()
