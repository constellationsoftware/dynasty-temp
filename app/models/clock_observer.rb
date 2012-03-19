class ClockObserver < ActiveRecord::Observer
    def before_create(clock)
        clock.time ||= Settings.clock.start
    end

    def before_update(clock)
        season = Season.current
        last_time = clock.time_was
=begin
        next_week_start = last_time.next_week(Settings.week_start_day.downcase.to_sym)

        # Figure out if we've crossed a weekly boundary
        if next_week_start && clock.time >= next_week_start
=end
        # Queue up the weekly maintenance tasks

        if last_time > clock.time # are we going back in time?
            # if we're resetting to season start, we'll need to do some cleanup
            if clock.time.to_date === season.start
                Game.all.each { |game| game.destroy }
                Game.all.each do |s|
                    s.outcome = nil
                    s.team_score = nil
                    s.opponent_score = nil
                    s.updated_at = nil
                    s.save
                end
                UserTeamLineup.historical.all.each { |lineup| lineup.destroy}
                UserTeam.all.each do |t|
                    t.balance = Settings.team.initial_balance
                    t.save
                end
                PlayerTeamHistory.all.each { |pth| pth.destroy}
                Trade.all.each { |trade| trade.destroy}
            end
        else
            clock.leagues.each do |league|
                league.calculate_game_points(last_time, clock.time)
            end
        end
        #end
    end
end
