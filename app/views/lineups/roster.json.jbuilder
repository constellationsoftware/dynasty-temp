json.array! @lineups do |json, lineup|
    json.position   lineup.position.abbreviation.upcase
    json.string     lineup.string
    if lineup.player_teams.empty?
        json.player nil
    else
        json.player do |json|
            json.partial!   '/players/player', :player => get_player(lineup.player_teams.first.player_id)
        end
    end
end
