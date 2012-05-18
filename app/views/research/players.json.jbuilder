json.players @players do |json, player|
    json.partial! 'player', :player => player
end
