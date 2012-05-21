class ClockObserver < ActiveRecord::Observer
    def before_create(clock)
        clock.time ||= Season.current.start_date.at_midnight
    end

    def before_update(clock)
        season = Season.current
        last_time = clock.time_was

        if clock.time.to_date === season.start_date # resetting
            reset_season season
        elsif last_time > clock.time # are we going back in time?
        else
            # detect day boundary
            unless clock.time.wday === clock.time_was.wday # unless we're transitioning within the same day
                if clock.is_team_payday?
                    week_range = clock.time.utc.advance(:weeks => -1)..clock.time.utc
                    db = ActiveRecord::Base.connection
                    ActiveRecord::Base.transaction do
                        # create point records for all teams
                        # WITH forfeiture for incomplete lineup
=begin
                        db.execute(<<QUERY
                            INSERT INTO dynasty_player_team_points(team_id, game_id, lineup_id, player_id, player_point_id)
                            SELECT team.id, (
                                SELECT id
                                FROM dynasty_games
                                WHERE date >= '#{week_range.first.at_midnight}' AND date < '#{week_range.last.at_midnight}'
                                    AND (away_team_id = team.id OR home_team_id = team.id)
                                LIMIT 1
                            ) AS game_id, pt.lineup_id, pt.player_id, pep.id
                            FROM (
                                SELECT pti.team_id AS id
                                FROM dynasty_player_teams pti
                                INNER JOIN dynasty_lineups l ON l.id = lineup_id
                                GROUP BY pti.team_id
                                HAVING COUNT(pti.team_id) = (SELECT COUNT(*) FROM dynasty_lineups)
                            ) AS team
                            INNER JOIN dynasty_player_teams pt ON team.id = pt.team_id
                            LEFT OUTER JOIN dynasty_player_event_points pep ON pt.player_id = pep.player_id
                                AND pep.event_datetime BETWEEN '#{week_range.first.at_midnight}' AND '#{week_range.last.at_midnight}'
                            WHERE pt.lineup_id IS NOT NULL
QUERY
                        )
=end
                        # WITHOUT forfeiture for empty lineup
                        db.execute(<<QUERY
                            INSERT INTO dynasty_player_team_points(team_id, game_id, lineup_id, player_id, player_point_id)
                            SELECT t.id, g.id, l.id, pt.player_id, pep.id
                            FROM dynasty_games g
                            JOIN dynasty_teams t ON g.away_team_id = t.id OR g.home_team_id = t.id
                            CROSS JOIN dynasty_lineups l
                            LEFT OUTER JOIN dynasty_player_teams pt ON pt.team_id = t.id AND pt.lineup_id = l.id
                            LEFT OUTER JOIN dynasty_player_event_points pep ON pt.player_id = pep.player_id
                            	AND pep.event_datetime BETWEEN '#{week_range.first.to_datetime}' AND '#{week_range.last.to_datetime}'
                            WHERE date >= '#{week_range.first.to_datetime}' AND date < '#{week_range.last.to_datetime}'
QUERY
                        )

                        # score all games simultaneously
                        db.execute(<<QUERY
                            UPDATE dynasty_games g
                            SET g.home_team_score = (
                                SELECT SUM(ROUND(pep.points / IF(l.string = 1, 1, 3), 1))
                                FROM dynasty_player_team_points ptp
                                INNER JOIN dynasty_lineups l ON ptp.lineup_id = l.id
                                INNER JOIN dynasty_player_event_points pep ON ptp.player_point_id = pep.id
                                WHERE ptp.game_id = g.id AND ptp.team_id = g.home_team_id
                            ), g.away_team_score = (
                                SELECT SUM(ROUND(pep.points / IF(l.string = 1, 1, 3), 1))
                                FROM dynasty_player_team_points ptp
                                INNER JOIN dynasty_lineups l ON ptp.lineup_id = l.id
                                INNER JOIN dynasty_player_event_points pep ON ptp.player_point_id = pep.id
                                WHERE ptp.game_id = g.id AND ptp.team_id = g.away_team_id
                            )
                            WHERE g.date >= '#{week_range.first.to_datetime}' AND g.date < '#{week_range.last.to_datetime}'
QUERY
                        )
                    end
                    leagues_with_games_for(week_range).each do |league|
                        league.games.each do |game|
                            # score games if not done yet
                            #unless game.scored?
                            #    game_scoring_event = Events::ScoreGames.create!
                            #    game_scoring_event.process game, week_range
                            #end

                            # pay winnings to participants
                            game_winnings_event = Events::PayGameWinnings.create!
                            game_winnings_event.process game
                        end

                        # luxury tax payouts
                        luxury_tax_event = Events::PayLuxuryTax.create!
                        luxury_tax_event.process league
                    end
                end

                if clock.is_player_payday?
                    week_range = clock.time.advance(:weeks => -1)..clock.time
                    leagues_with_games_for(week_range).each do |league|
                        league.teams.each do |team|
                            payroll_event = Events::PlayerPayroll.create!
                            payroll_event.process team
                        end
                    end
                end

                if clock.season_ended? season
                    # do season ending tasks
                end
            end
        end
    end

    protected
        def leagues_with_games_for(range)
            League.joins{[ games, teams, teams.player_teams ]}
                .includes{[ games, teams, teams.player_teams ]}
                .where{ games.date >> my{ range } }
        end

        def reset_season(season)
            # games = Game.where{ date >> (season.start_date..season.end_date) }
            games = Game.where{ date >= (season.start_date) }
            games.each do |game|
                game.home_team_score = nil
                game.away_team_score = nil
                game.event = nil
                game.save!
            end

            Events::Base.all.each do |event|
                event.destroy
            end
            Team.all.each do |team|
                team.balance = Settings.team.initial_balance
                team.save!
            end
            League.all.each do |league|
                league.balance = (Settings.league.new_team_contribution * Settings.league.capacity)
                league.save!
            end
            Trade.all.each { |trade| trade.destroy }
            Account.all.each{ |account| account.destroy }
            PlayerTeamPoint.all.each{ |p| p.destroy }
        end
end
