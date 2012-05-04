json.id         team.id
json.name       team.name
json.lineup     game.player_points_for(team) do |json, player_score|
    json.position       player_score.lineup.flex ? player_score.lineup.flex_positions.collect{ |p| p.abbreviation.upcase }.join('/') : player_score.lineup.position.abbreviation.upcase
    unless player_score.player_point_id.nil?
        json.name       player_score.player.first_initial_last
        json.team       player_score.score.team.name.abbreviation.upcase
        json.position   player_score.player.position.abbreviation.upcase
        json.points     '%.1f' % (player_score.score.points / (player_score.lineup.string === 2 ? Settings.bench_score_divisor : 1).to_f)
    end
end
