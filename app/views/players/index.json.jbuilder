json.players @players do |json, player|
    json.partial! 'player', :player => player
end
if @players.respond_to? :total_count
    json.total @players.total_count
end
