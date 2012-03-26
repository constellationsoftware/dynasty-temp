class ClockObserver < ActiveRecord::Observer
    def before_create(clock)
        clock.time ||= Season.current.start_date.at_midnight
    end

    def before_update(clock)
        season = Season.current
        last_time = clock.time_was

        if clock.time.to_date === season.start_date # resetting
            # games = Game.where{ date >> (season.start_date..season.end_date) }
            games = Game.where{ date >= (season.start_date) }
            games.each do |game|
                game.home_team_score = nil
                game.away_team_score = nil
                game.event = nil
                game.save!
            end
            #player_teams = PlayerTeamHistory.where{ created_at >> (season.start_date..season.end_date) }
            player_teams = PlayerTeamSnapshot.where{ created_at > (season.start_date) }
            player_teams.each do |player_team|
                player_team.destroy
            end

            UserTeam.all.each do |team|
                team.balance = Settings.team.initial_balance
                team.save!
            end
            League.all.each do |league|
                league.balance = (Settings.league.new_team_contribution * league.size)
                league.save!
            end
            Trade.all.each { |trade| trade.destroy }
            Account.all.each{ |account| account.destroy }
        elsif last_time > clock.time # are we going back in time?
            # if we're resetting to season start, we'll need to do some cleanup
        else
            # detect day boundary
            days_to_week_start = clock.time.days_to_week_start(Settings.week_start_day.to_sym)
            days_to_week_start_was = clock.time_was.days_to_week_start(Settings.week_start_day.to_sym)
            unless days_to_week_start === days_to_week_start_was # unless we're transitioning within the same day
                # frame from day start to end just in case our time is in the middle of the day
                day_start_time = clock.time.beginning_of_day
                day_end_time = clock.time.end_of_day
                week_start_time = clock.time.beginning_of_week(Settings.week_start_day.to_sym)
                week_end_time = clock.time.end_of_week(Settings.week_start_day.to_sym)
                week_range = week_start_time..week_end_time

                if days_to_week_start === 0 # crossed week beginning boundary
                    leagues_with_games_for(week_range).each do |league|
                        # beginning-of-week luxury tax payouts
                        luxury_tax_event = Events::LuxuryTax.create!
                        luxury_tax_event.process league
                    end
                elsif days_to_week_start === 2  # tuesday
                    games = Game.unscored
                        .with_teams
                        .where{ date >> my{ week_range } }
                    games.each do |game|
                        # calculate scoring
                        game_scoring_event = Events::ScoreGames.create!
                        game_scoring_event.process game, week_range

                        # pay winnings to participants
                        game_winnings_event = Events::PayGameWinnings.create!
                        game_winnings_event.process game
                    end
                elsif days_to_week_start === 6 # payday for the players!
                    league = leagues_with_games_for(week_start_time.advance(:weeks => -1)..week_end_time.advance(:weeks => -1))
                    leagues.each do |league|
                        league.player_teams.each do |player_team|
                            payroll_event = Events::PlayerPayroll.create!
                            payroll_event.process player_team

                            snapshot = PlayerTeamSnapshot.create! :team_id => team.id,
                                :lineup_id => player_team.lineup_id,
                                :player_id => player_team.player_id,
                                :event_id => payroll_event.id
                        end
                    end
                end

                if clock.time > season.end_date.to_time
                    # do season ending tasks
                    # collect trophy fee
                end
            end
        end
    end

    def leagues_with_games_for(range)
        League.joins{[ games, teams, teams.player_teams ]}
            .includes{[ games, teams, teams.player_teams ]}
            .where{ games.date >> my{ range } }
    end
end
