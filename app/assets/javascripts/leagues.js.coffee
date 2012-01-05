# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  players = $('#trade_requested_player_id').html()
  console.log(players)
  $('#trade_second_team_id').change ->
    team = $('#trade_second_team_id :selected').text()
    options = $(teams).filter("optgroup[label=#{team}]").html()
    console.log(options)
    if options
      $('#trade_requested_player_id').html(options)
      $('#trade_requested_player_id').parent().show()
    else
      $('#trade_requested_player_id').empty()
      $('#trade_requested_player_id').parent().hide()