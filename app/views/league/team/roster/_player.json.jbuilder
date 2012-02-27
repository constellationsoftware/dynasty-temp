json.team_name              player_team.team.name
json.id                     player_team.id
json.player_id              player_team.player_id
json.first_name             player_team.player_name.first_name
json.last_name              player_team.player_name.last_name
json.full_name              player_team.player_name.full_name
json.position               player_team.position.abbreviation
json.depth                  player_team.depth
json.bye_week               player_team.player_contract.bye_week
json.contract               player_team.player_contract.amount.to_money.format
json.points_last_season     player_team.player_points.points
json.points_per_dollar      player_team.player_points.points.to_f / player_team.player_contract.amount.to_f * 1000000
