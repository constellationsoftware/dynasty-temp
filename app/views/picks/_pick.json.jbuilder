json.id             pick.id
json.player_id      pick.player_id
json.team_id        pick.team_id
json.pick_order     pick.pick_order
json.picked_at      pick.picked_at
json.round          pick.round
if @player_team && @player_team.lineup
    json.lineup do |json|
        json.position   @player_team.lineup.position.abbreviation.upcase
        json.string     @player_team.lineup.string
    end
end
