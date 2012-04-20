json.array! @player_teams do |json, player_team|
    json.team do |json|
        json.id     player_team.team.uuid
        json.name   player_team.team.name
    end
    json.team_id    player_team.team_id
    json.player do |json|
        json.partial!   '/players/player', :player => player_team.player
    end
end
