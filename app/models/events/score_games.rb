class Events::ScoreGames < Events::Base
    has_many :games
    has_many :player_teams, :class_name => 'PlayerTeamSnapshot', :as => :event

    def process(game, range)
        process! do
            # score the games for this league
            game.home_team_score = points_for_team game.home_team, range
            game.away_team_score = points_for_team game.away_team, range
            game.event = self
            game.save!
        end
    end

    protected
        def points_for_team(team, range)
            # force_starters(team))
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
        end
end
