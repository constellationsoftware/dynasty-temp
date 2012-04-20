json.players @players do |json, player|
    json.partial! 'player', :player => player
end
if current_scopes[:page]
    json.total @players.total_count
end
