json.id                 game.id
json.date               game.date
json.week               game.week
json.team do |json|
    json.partial! 'team', :team => @team, :game => game
end
json.opponent do |json|
    json.partial! 'team', :team => game.opponent_for(@team), :game => game
end
json.score              game.score_for @team
json.opponent_score     game.score_for(game.opponent_for(@team))
json.won                game.won? @team
