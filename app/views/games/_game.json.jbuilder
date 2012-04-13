json.id                 game.id
json.date               game.date
json.week               game.week
json.home_team do |json|
    json.partial! 'team', :team => game.home_team, :game => game
end
json.away_team do |json|
    json.partial! 'team', :team => game.away_team, :game => game
end
json.home_team_score    game.home_team_score
json.away_team_score    game.away_team_score
if @team && (@team.id === game.home_team_id || @team.id === game.away_team_id)
    json.won            game.won? @team
end
