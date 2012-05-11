# == Schema Information
#
# Table name: dynasty_events
#
#  id           :integer(4)      not null, primary key
#  type         :string(255)
#  source_id    :integer(4)
#  source_type  :string(255)
#  target_id    :integer(4)
#  target_type  :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  processed_at :datetime
#

class Events::ScoreGames < Events::Base
    has_many :games

    def process(game, range)
        process! do
            raise
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
            # promote available players to fill empty slots
            team.fill_lineup_for_game(game)

            player_lineups = PlayerTeam.joins{ lineup }.where{ team_id == my{ team.id } }
            return nil if player_lineups.count < lineups.count # if we're still short on players, forfeit

            players = PlayerTeam.joins{[ lineup, player_event_points ]}
                .where{ (team_id == my{ team.id }) & (lineup_id != nil) & (player_event_points.event_datetime >> (range)) }
                .order{ lineup_id }
                .select{[ id, lineup.string, player_event_points.id.as('points_id'), player_event_points.points ]}

            game_points = players.inject(0.to_f) do |sum, player|
                # create historical score record
                PlayerTeamPoint.create :team_id => team.id,
                    :game_id => game.id,
                    :lineup_id => player['lineup_id'],
                    :player_id => player['player_id'],
                    :player_point_id => player['points_id']
                ret = sum + ((player['points'].to_f / (player['string'] === 2 ? Settings.bench_score_divisor : 1)).round(1))
                ret.round(1)
            end

            # create records for lineups which didn't have either players or points for the players
            puts (player_lineups - players).inspect
            (player_lineups - players).each do |player_team|
                PlayerTeamPoint.create :team_id => team.id,
                    :player_id => player_team.player_id,
                    :game_id => game.id,
                    :lineup_id => player_team.lineup_id
            end

            game_points
        end
end
