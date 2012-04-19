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
                    week_range = clock.time.advance(:weeks => -1)..clock.time
                    leagues_with_games_for(week_range).each do |league|
                        league.games.each do |game|
                            # score games if not done yet
                            unless game.scored?
                                game_scoring_event = Events::ScoreGames.create!
                                game_scoring_event.process game, week_range
                            end

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
            #player_teams = PlayerTeamHistory.where{ created_at >> (season.start_date..season.end_date) }
=begin
            player_teams = PlayerTeamSnapshot.where{ created_at > (season.start_date) }
            player_teams.each do |player_team|
                player_team.destroy
            end
=end

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
        end
end
