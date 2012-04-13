json.array! @lineups do |json, lineup|
    json.id         lineup.id
    json.position   lineup.position.abbreviation.upcase
    json.flex       lineup.flex
    if lineup.player_teams.size > 0
        json.player do |json|
            json.partial! 'leagues/team/lineup/player', :player_team => lineup.player_teams[0]
        end
    end
end
