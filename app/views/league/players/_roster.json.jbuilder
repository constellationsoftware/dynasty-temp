json.id                     player.id
json.drafted_team           player.team_link.andand.user_team.andand.name
json.bye_week               player.contract.bye_week
json.full_name              player.name.full_name
json.contract_amount        player.contract.amount
json.position               player.position.andand.abbreviation.andand.upcase
json.points_last_season     player.points.first.points
json.points_per_dollar      (player.points.first.points.to_f / player.contract.amount.to_f) * 1000000

if player.team_link.depth == 1
    json.depth              'Starter'
else
    json.depth              'Bench'
end
