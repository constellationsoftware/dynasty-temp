json.id         team.id
json.name       team.name
json.lineup     game.player_points_for(team) do |json, player_score|
    json.position   player_score.lineup.flex ? player_score.lineup.flex_positions.collect{ |p| p.abbreviation.upcase }.join('/') : player_score.lineup.position.abbreviation.upcase
    unless player_score.player_id.nil?
        json.name       player_score.player.name.last_with_first_initial
        json.team       player_score.player.real_team.display_name.abbreviation.upcase
        json.position   player_score.player.position.abbreviation.upcase
        if game.week === player_score.player.contract.bye_week
            json.points 'BYE'
        elsif player_score.score
            json.points '%.1f' % (player_score.score.points / (player_score.lineup.string === 2 ? Settings.bench_score_divisor : 1).to_f)
        else
            json.points 'N/A'
        end
    end
end
