json.id                     player.id
json.name do |json|
    json.first_name         player['name.first_name']
    json.last_name          player['name.last_name']
end
json.real_team do |json|
    json.name do |json|
        json.abbreviation   player.real_team.name.abbreviation.try( :upcase )
    end
end
json.contract do |json|
    json.amount             player['contract.amount']
    json.summary            player['contract.summary']
    json.end_year           player['contract.end_year']
    json.bye_week           player['contract.bye_week']
end
json.position do |json|
    json.abbreviation       player['position.abbreviation'].upcase
end
json.points do |json|
    json.points             player['points.points']
    json.passing_points     player['points.passing_points']
    json.rushing_points     player['points.rushing_points']
    json.fumbles_points     player['points.fumbles_points']
    json.defensive_points   player['points.defensive_points']
    json.scoring_points     player['points.scoring_points']
    json.games_played       player['points.games_played']
end
