class Events::ScoreGames < Events::Base
    has_many :games

    def process(game, range)
        process! do
            lineups = Lineup.select{ id }.order{ id }
            # score the games for this league
            game.home_team_score = points_for_team game, game.home_team, range, lineups
            game.away_team_score = points_for_team game, game.away_team, range, lineups
            game.event = self
            game.save!
        end
    end

    protected
        def points_for_team(game, team, range, lineups)
            all_lineup_ids = lineups.collect{ |l| l.id }
            player_lineup_ids = []
            players = PlayerTeam.joins{[ lineup, player_event_points, player_event_points.event ]}
                .where{ (team_id == my{ team.id }) & (lineup_id != nil) & (player_event_points.event.start_date_time >> (range)) }
                .order{ lineup_id }
                .select{[ player_id, lineup_id, lineup.string, player_event_points.id.as('points_id'), player_event_points.points ]}

            game_points = players.inject(0) do |sum, player|
                player_lineup_ids << player['lineup_id']

                # create historical score record
                PlayerTeamPoint.create :team_id => team.id,
                    :game_id => game.id,
                    :lineup_id => player['lineup_id'],
                    :player_point_id => player['points_id']
                sum + (player['points'] / (player['string'] === 2 ? Settings.bench_score_divisor : 1)).to_f
            end

            # create records for lineups which didn't have either players or points for the players
            (all_lineup_ids - player_lineup_ids).each do |l|
                PlayerTeamPoint.create :team_id => team.id,
                    :game_id => game.id,
                    :lineup_id => l
            end

            game_points

=begin
            Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{PlayerTeam.table_name}.team_id = #{team.id}"
            lineups = Lineup.joins{[ player_teams, player_teams.player_event_points.outer, player_teams.player_event_points.event.outer ]}
                .where{ (player_teams.player_event_points.event.start_date_time >> (range)) | (player_teams.player_event_points.event.start_date_time == nil) }
                .order{ id }
                .select{[ id, string, player_teams.player_id, player_teams.player_event_points.id.as('event_points_id'), player_teams.player_event_points.points ]}
            lineups = Lineup.joins{ player_teams.outer }.order{ id }.select{[ id, string, player_teams.player_id ]}
            lineups.inject(0) do |sum, lineup|
                event_points = nil
                unless lineup['player_id'].nil?
                    # still need to outer join since we don't know if the date range will contain a score
                    event_points = PlayerEventPoint.joins{ event.outer }
                        .where{ (event.start_date_time >> (range)) & (player_id == my{ lineup['player_id'] }) }
                        .select{[ id, points ]}
                # create historical score record
                PlayerTeamPoint.create :team_id => team.id,
                    :game_id => game.id,
                    :lineup_id => lineup.id,
                    :player_point_id => lineup['event_points_id']
                sum + ((lineup['points'] or 0) / (lineup.string === 2 ? Settings.bench_score_divisor : 1)).to_f
            end
=end

            # force_starters(team))
=begin
            starter_points = PlayerEventPoint.select{ sum(points).as('points') }
                .joins{[ event, player.player_teams.team ]}
                .where{ player.player_teams.team.id == my{ team.id } }
                .where{ player.player_teams.depth == 1 }
                .where{ event.start_date_time >> (range) }
                .first.points
            bench_points = PlayerEventPoint.select{ sum(points).as('points') }
                .joins{[ event, player.player_teams.team ]}
                .where{ player.player_teams.team.id == my{ team.id } }
                .where{ player.player_teams.depth == 0 }
                .where{ event.start_date_time >> (range) }
                .first.points
            starter_points.to_f + (bench_points.to_f / 3)
=end
        end
end
