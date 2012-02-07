json.array! @games do |json, game|
    json.partial! 'league/team/games/game', :game => game
end
