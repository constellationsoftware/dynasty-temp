json.games @games do |json, game|
    json.partial! 'leagues/team/games/game', :game => game
end

json.ratio do |json|
    json.wins = @ratio[:wins]
    json.losses = @ratio[:losses]
end
json.name       @team.name
json.balance    @team.balance.format
