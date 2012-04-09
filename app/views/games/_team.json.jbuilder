json.id     team.id
json.name   team.name
if game.scored?
    json.players team.player_teams do |json, player_team|
        json.partial! 'player', :player => player_team.player
        if player_team.lineup_id
            json.position   player_team.lineup.position.abbreviation
            json.depth      1
        else
            json.position   player_team.player.position.abbreviation
            json.depth      0
        end
        if current_scopes[:with_points]
            json.points         PlayerEventPoint.by_player(player_team.player_id)
                                    .in_range(game.date..game.date.advance(:weeks => 1)).first.try(:points)
        end
    end
end
