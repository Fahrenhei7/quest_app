# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# adding new fielt to keys
jQuery ->
  $(document).on 'click', '#add-key-button', ->
    $lastkeyField = $('.single-key:last-of-type').clone()
    $lastkeyField.find('label').remove()
    $lastkeyField.find('input').val("")

    $(".keys").append($lastkeyField)
