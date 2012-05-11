

json.players(@players) do |json, player|
  json.player_id             player.id
  json.player_name           player.fname
  json.position              player.position.abbreviation
  json.position_id           player.position.id
  json.designation           player.position.designation
  json.bye_week              player.contract.bye_week
  json.contract_end          player.contract.end_year
  json.contract_total        player.contract.summary
  json.contract_salary       player.contract.amount
  json.team_id               player.real_team.id
  json.team_name             player.real_team.nickname
  json.points                player.points.points
  json.passing_points        player.points.passing_points
  json.rushing_points        player.points.rushing_points
  json.defensive_points      player.points.defensive_points
  json.fumbles_points        player.points.fumbles_points
  json.scoring_points        player.points.scoring_points
  json.last_season           player.points_last_season
  json.per_dollar            player.points_per_dollar
  json.games_played          player.points.games_played
end
