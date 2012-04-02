json.array! @games do |json, game|
    json.partial! 'leagues/team/games/game', :game => game
end
