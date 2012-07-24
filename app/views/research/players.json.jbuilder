json.array! @players do |json, player|
    json.partial! 'player', :player => player, :picked_player_ids => @picked_player_ids, :favorites => @favorites
end
