json.array! @players do |json, player|
    json.partial! 'league/players/roster', :player => player
end

