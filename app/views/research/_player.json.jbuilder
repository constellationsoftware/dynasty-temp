json.id                     player.id
json.name do |json|
    json.first_name         player.send 'name.first_name'
    json.last_name          player.send 'name.last_name'
end
json.real_team do |json|
    json.display_name do |json|
        json.abbreviation   player.send('real_team.display_name.abbreviation').try( :upcase )
    end
end
salary = player.send('contract.amount').to_i
json.contract do |json|
    json.amount             salary
    json.summary            player.send 'contract.summary'
    json.end_year           player.send 'contract.end_year'
    json.bye_week           player.send 'contract.bye_week'
end
json.position do |json|
    json.abbreviation       player.send('position.abbreviation').upcase
end
points = player.send('points.points').to_i
json.points do |json|
    json.points             points
    json.passing_points     player.send 'points.passing_points'
    json.rushing_points     player.send 'points.rushing_points'
    json.fumbles_points     player.send 'points.fumbles_points'
    json.defensive_points   player.send 'points.defensive_points'
    json.scoring_points     player.send 'points.scoring_points'
    json.games_played       player.send 'points.games_played'
end
json.dollars_per_point      points === 0 ? 0 : (salary / points)
if picked_player_ids
    json.available          !(picked_player_ids.include?(player.id))
end
