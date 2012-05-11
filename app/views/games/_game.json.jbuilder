json.id                 game.id
json.date               game.date
json.week               game.week
json.home_team do |json|
    json.partial! 'team', :team => game.home_team, :game => game
    game.home_team_score if game.scored?
end
json.away_team do |json|
    json.partial! 'team', :team => game.away_team, :game => game
    game.away_team_score if game.scored?
end

if @team && (@team.id === game.home_team_id || @team.id === game.away_team_id)
    json.won            game.won? @team
end
