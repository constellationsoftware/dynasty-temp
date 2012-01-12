class Clock < ActiveRecord::Base
    def next_week
        self.time = self.time.next_week.at_midnight
        self.save!
        self.time
        
        ## do payroll
        #UserTeam.each do |team|
        #  my_season_payroll = team.players.to_a.sum(&:amount)
        #  my_weekly_payroll = my_season_payroll / team.schedules.count
        #  team.balance - my_weekly_payroll.to_money
        #  team.save
        #end
    end

    def reset
        self.time = Date.new(2011, 9, 8).at_midnight
        self.save!
        self.time

        Game.all.each { |game| game.destroy }
    end

    def present
        self.time = Time.now
        self.save!
        self.time
    end

    def nice_time
        self.time.strftime("%B %e, %Y")
    end

    def weekly_points_for_team(team)
        week_end = self.time
        week_start = self.time.advance :weeks => -1

        PlayerEventPoint.select { sum(points).as('points') }.joins { [event, player.team_link.team] }.where { player.team_link.team.id == my { team.id } }.where { player.team_link.depth == 1 }.where { (event.start_date_time >= week_start) & (event.start_date_time < week_end) }.first.points
    end

    def week
        beginning = Date.new(2011, 9, 8).at_midnight
        week = ((self.time.to_date - beginning.to_date) / 7).to_i
        week
    end



    def calculate_points_for_league(league)
        puts self.time
        puts league.inspect
        beginning = Date.new(2011, 9, 8).at_midnight
        
        league.teams.each { |team|
            points = weekly_points_for_team(team)
            week = ((self.time.to_date - beginning.to_date) / 7).to_i + 1
            #puts "points: #{points} week: #{week}"
            Game.create :team_id => team.id, :week => week, :points => (points ? points : 0)
        }
    end
end
