json.id     team.id
json.name   team.name
json.is_online team.is_online
if current_scopes[:with_picks]
    json.picks team.picks do |json, pick|
        json.id         pick.id
        json.player_id  pick.player_id
        json.team_id    team.id
        json.pick_order pick.pick_order
        json.picked_at  pick.picked_at
        json.round      pick.round
    end
end
